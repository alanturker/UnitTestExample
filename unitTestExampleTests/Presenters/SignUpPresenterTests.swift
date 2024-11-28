//
//  SignUpPresenterTests.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 25.10.2024.
//

import XCTest
@testable import unitTestExample

final class SignUpPresenterTests: XCTestCase {
    private var signUpFormModel: SignUpFormModel!
    private var mockSignUpModelValidator: MockSignUpModelValidator!
    private var mockSignUpWebService: MockSignUpWebService!
    private var sut: SignUpPresenter!
    private var mockSignUpViewDelegate: MockSignUpViewDelegate!
    override func setUpWithError() throws {
        signUpFormModel = SignUpFormModel(firstName: "kerker",
                                  lastName: "blabla",
                                  email: "test@test.com",
                                  password: "123456789",
                                  repeatPassword: "123456789")
        
        mockSignUpModelValidator = MockSignUpModelValidator()
        mockSignUpWebService = MockSignUpWebService()
        mockSignUpViewDelegate = MockSignUpViewDelegate()
        
        sut = SignUpPresenter(formModelValidator: mockSignUpModelValidator,
                              signUpWebService: mockSignUpWebService,
                              delegate: mockSignUpViewDelegate)
        
    }

    override func tearDownWithError() throws {
        signUpFormModel = nil
        mockSignUpModelValidator = nil
        mockSignUpWebService = nil
        sut = nil
        mockSignUpViewDelegate = nil
        MockSignUpWebService.error = nil
    }
    
    func testSignUpPresenter_WhenInformationProvided_WillValidateEachProperty() {
        //Arrenge
        
        //Act
        sut.processUserSignUp(formModel: signUpFormModel)
        //Assert
        
        XCTAssertTrue(mockSignUpModelValidator.isFirstNameValid, "First name not validated")
        XCTAssertTrue(mockSignUpModelValidator.doPasswordsMatch, "Password's equality not validated")
    }
    
    func testSignUpPresenter_WhenGivenValidFromModel_ShouldCallSignUpMethod() {
        //Arrenge
        
        //Act
        sut.processUserSignUp(formModel: signUpFormModel)
        
        //Assert
        XCTAssertTrue(mockSignUpWebService.isSignUpMethodCalled, "The signUp() method not called in the SignUpWebService class")
    }
    
    func testSignUpPresenter_WhenSignUpSuccessfull_ShouldCallSuccessOnViewDelegate() {
        //Arrenge
        let myExpectation = self.expectation(description: "Expected to be successfullSignUp() method to be called")
        mockSignUpViewDelegate.expectation = myExpectation
        
        //Act
        sut.processUserSignUp(formModel: signUpFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSignUpViewDelegate.successfullSignUpCounter, 1, "It should only signUp 1 time but its not")
    }

    func testSignUpPresenter_WhenSignUpFailed_ShouldReturnError() {
        //Arrenge
        let myExpectation = self.expectation(description: "Expected to be errorHnadler() method to be called")
        mockSignUpViewDelegate.expectation = myExpectation
        
        let errorDescription = "A localized descritption of an Error"
        MockSignUpWebService.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        //Act
        sut.processUserSignUp(formModel: signUpFormModel)
        self.wait(for: [myExpectation], timeout: 5)
        
        //Assert
        XCTAssertEqual(mockSignUpViewDelegate.signUpError, SignUpError.failedRequest(description: errorDescription), "processUserSignUp() method did not return expected error.")
    }
}
