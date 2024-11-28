//
//  SignUpWebService.swift
//  unitTestExample
//
//  Created by Turker Alan on 24.10.2024.
//

import Foundation

class SignUpWebService: SignUpWebServiceProtocol {
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUp(with formModel: SignUpFormRequestModel, completionHandler: @escaping (SignUpResponseModel?, SignUpError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
        ///TODO: - CREATE a unit test to test unique error message send when url is nil
            completionHandler(nil, SignUpError.invalidUrlString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            ///TODO: - create a unit test to handle error
            if let signUpError = error {
                completionHandler(nil, SignUpError.failedRequest(description: signUpError.localizedDescription))
                return
            }
            if let data,
               let signUpResponseModel = try? JSONDecoder().decode(SignUpResponseModel.self, from: data) {
                
                completionHandler(signUpResponseModel, nil)
            } else {
                ///TODO: - create a unit test to handle error
                completionHandler(nil, SignUpError.responseModelParsing)
            }
        }
        
        dataTask.resume()

    }
}
