//
//  SignUpPresenter.swift
//  unitTestExample
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation

class SignUpPresenter: SignUpPresenterProtocol {
    private var formModelValidator: SignUpModelValidatorProtocol
    private var signUpWebService: SignUpWebServiceProtocol
    private weak var delegate: SignUpViewDelegateProtocol?
    
    required init(formModelValidator: SignUpModelValidatorProtocol,
         signUpWebService: SignUpWebServiceProtocol,
         delegate: SignUpViewDelegateProtocol?) {
        self.formModelValidator = formModelValidator
        self.signUpWebService = signUpWebService
        self.delegate = delegate
    }
    
    func processUserSignUp(formModel: SignUpFormModel) {
        
        if !formModelValidator.isFirstNameValid(firstName: formModel.firstName) {
            return
        }
        
        if !formModelValidator.doPasswordsMatch(password: formModel.password, repeatPawword: formModel.repeatPassword) {
            return
        }
        
        let formRequestModel = SignUpFormRequestModel(firstName: formModel.firstName,
                                                      lastName: formModel.lastName,
                                                      email: formModel.email,
                                                      password: formModel.password)
        signUpWebService.signUp(with: formRequestModel) { [weak self] responseModel, error in
            //TODO: -
            if let signUpError = error {
                self?.delegate?.errorHandler(error: signUpError)
                return
            }
            
            if let responseModel {
                self?.delegate?.successfullSignUp()
            }
        }
        
    }
}
