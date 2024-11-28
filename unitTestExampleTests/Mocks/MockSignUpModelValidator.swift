//
//  MockSignUpModelValidator.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation
@testable import unitTestExample
class MockSignUpModelValidator: SignUpModelValidatorProtocol {
    var isFirstNameValid: Bool = false
    var doPasswordsMatch: Bool = false
    func isFirstNameValid(firstName: String) -> Bool {
        isFirstNameValid = true
        return isFirstNameValid
    }
    
    func doPasswordsMatch(password: String, repeatPawword: String) -> Bool {
        doPasswordsMatch = true
        return doPasswordsMatch
    }
}
