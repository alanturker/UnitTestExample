//
//  SignUpFormModelValidator.swift
//  unitTestExample
//
//  Created by Turker Alan on 24.10.2024.
//

import Foundation

class SignUpFormModelValidator: SignUpModelValidatorProtocol {
    private let invalidCharacters = CharacterSet(charactersIn: "{}$#%*&^.,/?!@")
    
    func isFirstNameValid(firstName: String) -> Bool {
        
        var returnValue = true
        
        if firstName.count < SignUpConstants.firstNameMinLength || firstName.count > SignUpConstants.firstNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func doPasswordsMatch(password: String, repeatPawword: String) -> Bool {
        return password == repeatPawword
    }
    
    func isFirstNameHaveInvalidCharacters(firstName: String) throws {
        if firstName.rangeOfCharacter(from: invalidCharacters) != nil {
            throw SignUpError.illegalCharactersFound
        }
    }
}
