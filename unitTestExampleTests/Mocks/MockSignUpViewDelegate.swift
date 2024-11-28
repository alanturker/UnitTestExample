//
//  MockSignUpViewDelegate.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation
import XCTest
@testable import unitTestExample

class MockSignUpViewDelegate: SignUpViewDelegateProtocol {
    var expectation: XCTestExpectation?
    var successfullSignUpCounter = 0
    var signUpError: SignUpError?
    
    func successfullSignUp() {
        successfullSignUpCounter += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignUpError) {
        signUpError = error
        expectation?.fulfill()
    }
    
    
}
