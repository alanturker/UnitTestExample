//
//  MockSignUpWebService.swift
//  unitTestExampleTests
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation
@testable import unitTestExample

class MockSignUpWebService: SignUpWebServiceProtocol {
    var isSignUpMethodCalled: Bool = false
    static var error: Error?
    
    func signUp(with formModel: SignUpFormRequestModel, completionHandler: @escaping (SignUpResponseModel?, SignUpError?) -> Void) {
        isSignUpMethodCalled = true
        if let error = MockSignUpWebService.error {
            completionHandler(nil, SignUpError.failedRequest(description: error.localizedDescription))
        } else {
            let responseModel = SignUpResponseModel(status: "Ok")
            completionHandler(responseModel, nil)
        }
    }
}
