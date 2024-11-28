//
//  testUnit.swift
//  unitTestExample
//
//  Created by Turker Alan on 23.10.2024.
//

import XCTest
@testable import unitTestExample

final class unitTests: XCTestCase {
    
    var sut: SignUpFormModelValidator!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("setUp class method")
        sut = SignUpFormModelValidator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDown class method")
        sut = nil
    }
    
    func testSignUpFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        //Arrange
        
        //Act
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "kerker")
        //Assert
        
        XCTAssertTrue(isFirstNameValid, "The  isFirstNameValid should return TRUE for valid first name but returned FALSE")
    }
    
    func testSignUpFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        //Arrange
        
        //Act
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "K")
        //Assert
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid should return False for shorter than \(SignUpConstants.firstNameMinLength) characters but returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalse() {
        //Arrange
        
        //Act
        
        let isFirstNameValid = sut.isFirstNameValid(firstName: "KERKERKERKER")
        //Assert
        
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid should return False for longer than \(SignUpConstants.firstNameMaxLength) characters but returned TRUE")
    }
    func testSignUpFormModelValidator_WhenEqualPasswordsProvided_ShouldReturnTrue() {
        //Arrange
        
        //Act
        
        let doPasswordMatch = sut.doPasswordsMatch(password: "123456789", repeatPawword: "123456789")
        //Assert
        
        XCTAssertTrue(doPasswordMatch, "The doPasswordMatch should return TRUE for matching Passwords but returned FALSE")
    }

    func testSignUpFormModelValidator_WhenNotEqualPasswordsProvided_ShouldReturnFalse() {
        //Arrange
        
        //Act
        
        let doPasswordMatch = sut.doPasswordsMatch(password: "123456789", repeatPawword: "123689")
        //Assert
        
        XCTAssertFalse(doPasswordMatch, "The doPasswordMatch should return FALSE for matching Passwords but returned TRUE")
    }
    
    func testSignUpFormModelValidator_WhenInvalidNameProvided_ThrowsAnError() {
        //Arrenge
    
        //Act and Assert
        XCTAssertThrowsError(try sut.isFirstNameHaveInvalidCharacters(firstName: "kerker*"), "isFirstNameHaveInvalidCharacters() method should throw an error if firstName contains illegal characters") { errorThrown in
            XCTAssertEqual(errorThrown as? SignUpError, SignUpError.illegalCharactersFound, "the errorThrown should be illegalCharactersFound")
        }
        
        
    }
    
    func testSignUpFormModelValidator_WhenValidNameProvided_ThrowsNoError() {
        //Arrenge
        
        //Act and Assert
        XCTAssertNoThrow(try sut.isFirstNameHaveInvalidCharacters(firstName: "kerker"), "isFirstNameHaveInvalidCharacters() method should NOT throw an error if firstName NOT contains illegal characters")
    }
}
