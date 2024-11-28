//
//  SignUpViewDelegateProtocol.swift
//  unitTestExample
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation

protocol SignUpViewDelegateProtocol: AnyObject {
    func successfullSignUp()
    func errorHandler(error: SignUpError)
}
