//
//  MockSignUpPresenter.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 28.10.2024.
//

import Foundation
@testable import unitTestExample

class MockSignUpPresenter: SignUpPresenterProtocol {
    var processUserSignUpCalled: Bool = false
    
    required init(formModelValidator: any unitTestExample.SignUpModelValidatorProtocol, signUpWebService: any unitTestExample.SignUpWebServiceProtocol, delegate: (any unitTestExample.SignUpViewDelegateProtocol)?) {
        //TODO: -
    }
    
    func processUserSignUp(formModel: unitTestExample.SignUpFormModel) {
        processUserSignUpCalled = true
    }
    
    
}
