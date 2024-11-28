//
//  SignUpViewControllerTests.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 27.10.2024.
//

import XCTest
@testable import unitTestExample

final class SignUpViewControllerTests: XCTestCase {
    var storyBoard: UIStoryboard!
    var sut: SignUpViewController!
    override func setUpWithError() throws {
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyBoard = nil
        sut = nil
    }

  
    func testSignUpViewController_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        //Arrenge
       
        let firstNameTextField = try XCTUnwrap(sut?.firstNameTextField, "firstNameTextField is not connected to IBOutlet")
        //Act
        
        
        //Assert
        XCTAssertEqual(firstNameTextField.text, "", "firstNameTextField is not empty when the SignUpViewController initially loaded")
    }
    
    func testSignUpViewController_WhenCreated_HasSigUpButtonAndAction() throws {
        //Arrenge
        let signUpButton: UIButton = sut.signUpButton
        
        let signUpButtonActions = try XCTUnwrap(signUpButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "There is no assigned actions to signUpButton")
        
        //Act
        
        //Assert
        XCTAssertEqual(signUpButtonActions.count, 1)
        XCTAssertEqual(signUpButtonActions.first, "didTapSignUpButton:", "signUpButton did not have didTapSignUpButton() method")
        
    }

    func testSignUpViewController_WhenSignUpButtonTapped_InvokesSignUpProcess() {
        //Arrenge
        let mockSignUpModelValidator = MockSignUpModelValidator()
        let mockSignUpWebService = MockSignUpWebService()
        let mockSignUpViewDelegate = MockSignUpViewDelegate()
        
        let mockSignUpPresenter = MockSignUpPresenter(formModelValidator: mockSignUpModelValidator,
                                                      signUpWebService: mockSignUpWebService,
                                                      delegate: mockSignUpViewDelegate)
        sut.signUpPresenter = mockSignUpPresenter
        
        //Act
        sut.signUpButton.sendActions(for: .touchUpInside)
        
        //Assert
        XCTAssertTrue(mockSignUpPresenter.processUserSignUpCalled, "The processUserSignUp() method not called when the signUpButton tapped in SignUpViewController")
    }
}
