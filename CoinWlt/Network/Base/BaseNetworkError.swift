//
//  BaseNetworkError.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case notFound
    case badUrl
    case badFormat
    case failure(message: String)
    case failed(error: Error)
}

// MARK: - ErrorResponse
struct ErrorResponse: Codable {
    let errors: Errors
}

// MARK: - Errors
struct Errors: Codable {
    let nonFieldErrors: NonFieldErrors

    enum CodingKeys: String, CodingKey {
        case nonFieldErrors = "non_field_errors"
    }
}

// MARK: - NonFieldErrors
struct NonFieldErrors: Codable {
    let code, message: String
}

// MARK: - Error Resolver
struct ErrorSerializer {
    static func networkError(error: Error) -> String {
        var errorStr = ""
        if case NetworkError.badFormat = error {
            errorStr = "Bad format"
        } else if case NetworkError.failed(error: let innerError) = error {
            errorStr = "Web request failed due to \(innerError.localizedDescription)"
        } else if case NetworkError.failure(message: let msg) = error {
            errorStr = msg
        } else {
            errorStr = "Unknown error: \(error.localizedDescription)"
        }

        return errorStr
    }
}
