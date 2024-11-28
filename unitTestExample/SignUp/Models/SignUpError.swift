//
//  SignUpErrors.swift
//  unitTestExample
//
//  Created by Turker Alan on 24.10.2024.
//

import Foundation

enum SignUpError: LocalizedError, Equatable {
    case responseModelParsing
    case invalidUrlString
    case failedRequest(description: String)
    case illegalCharactersFound
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidUrlString, .responseModelParsing, .illegalCharactersFound:
            return ""
        }
    }
}

