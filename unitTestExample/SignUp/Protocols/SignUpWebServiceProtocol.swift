//
//  SignUpWebServiceProtocol.swift
//  unitTestExample
//
//  Created by Turker Alan on 25.10.2024.
//

import Foundation

protocol SignUpWebServiceProtocol {
    func signUp(with formModel: SignUpFormRequestModel, completionHandler: @escaping (SignUpResponseModel?, SignUpError?) -> Void)
}
