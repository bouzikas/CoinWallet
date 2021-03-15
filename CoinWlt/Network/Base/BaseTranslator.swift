//
//  BaseTranslator.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class BaseTranslator {

    /// A generic JSON translator
    ///
    /// - Parameters:
    ///   - type: the type which the translation should decode from
    ///   - data: binary data to be decoded
    /// - Throws: Translation error or `NetworkError`
    /// - Returns: template T which is type decodable
    public func translate<T>(_ type: T.Type, _ data: Data?) throws -> T where T: Decodable {
        do {
            return try JSONDecoder().decode(type, from: data!)
        } catch _ {
            /// try to translate the error in case its in acceptable form
            /// that can be found in `BaseNetworkError.swift`
            throw self.translateError(data)
        }
    }

    /// Handles the default error for this application
    ///
    /// - Parameter data: error message in binary to be decoded
    /// - Returns: the corresponding error from data or generic translation `Error`.
    public func translateError(_ data: Data?) -> Error {
        do {
            let errorMessage = try JSONDecoder().decode(
                ErrorResponse.self,
                from: data!
            ).errors.nonFieldErrors.message

            return NetworkError.failure(message: errorMessage)
        } catch let translationError {
            return translationError
        }
    }
}
