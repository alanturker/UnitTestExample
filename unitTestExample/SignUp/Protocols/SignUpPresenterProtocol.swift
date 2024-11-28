//
//  SignUpPresenterProtocol.swift
//  unitTestExample
//
//  Created by Turker Alan on 28.10.2024.
//

import Foundation

protocol SignUpPresenterProtocol: AnyObject {
    init(formModelValidator: SignUpModelValidatorProtocol,
         signUpWebService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol?)
    func processUserSignUp(formModel: SignUpFormModel)
}
