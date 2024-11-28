//
//  SignUpWebServiceTests.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 24.10.2024.
//

import XCTest
@testable import unitTestExample

final class SignUpWebServiceTests: XCTestCase {
    
    var sut: SignUpWebService!
    var signUpFormRequestModel: SignUpFormRequestModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignUpWebService(urlString: SignUpConstants.signUpUrlString,
                                   urlSession: urlSession)
        
        signUpFormRequestModel = SignUpFormRequestModel(firstName: "kerker",
                                                            lastName: "blabla",
                                                            email: "test@test.com",
                                                            password: "123456789")
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        signUpFormRequestModel = nil
        MockUrlProtocol.stubResponseData = nil
        MockUrlProtocol.error = nil
    }

    func testSignUpWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        //Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
       
        let expectation = expectation(description: "Expectation for SignUpWeb Service Response")
        
        //Act
        sut.signUp(with: signUpFormRequestModel) { signUpResponseModel, signUpError in
            
            //Assert
            XCTAssertEqual(signUpResponseModel?.status, "ok", "response of signUp method should be OK but its different")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebService_WhenReceivedDifferentJsonResponse_ErrorTookPlace() {
        //Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let expectation = expectation(description: "signUp() method requires different structure for response model")
        
        //Act
        sut.signUp(with: signUpFormRequestModel) { signUpResponseModel, signUpError in
            
            //Assert
            XCTAssertNil(signUpResponseModel, "the response model for request contains unknown Json response, should have been NIL")
            XCTAssertEqual(signUpError, SignUpError.responseModelParsing, "signUp() method did not return expected error.")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignUpWebService_WhenEmptyURLProvided_ReturnError() {
        //Arrange
        let expectation = expectation(description: "An empty String URL expectation")
        sut = SignUpWebService(urlString: "")
        
        //Act
        sut.signUp(with: signUpFormRequestModel) { signUpResponseModel, signUpError in
            //Assert
            XCTAssertEqual(signUpError, SignUpError.invalidUrlString, "The signUp() method did not return expected error.")
            XCTAssertNil(signUpResponseModel, "When invalid string URL takes place responseModel should be NIL")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
    }

    func testSignUpWebService_WhenURLRequestFails_ReturnErrorMessageDescription() {
        //Arrenge
        let expectation = expectation(description: "A failed Request expectation")
        let errorDescription = "A localized descritption of an Error"
        MockUrlProtocol.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        //Act
        sut.signUp(with: signUpFormRequestModel) { signUpResponseModel, signUpError in
            //Assert
            XCTAssertEqual(signUpError, SignUpError.failedRequest(description: errorDescription), "signUp() method did not return an expected Error")
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2)
    }
}
