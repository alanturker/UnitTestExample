//
//  SignUpModelValidatorProtocol.swift
//  unitTestExample
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation

protocol SignUpModelValidatorProtocol {
    func isFirstNameValid(firstName: String) -> Bool
    func doPasswordsMatch(password: String, repeatPawword: String) -> Bool
}
