//
//  TransactionsTranslator.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

internal class TransactionsTranslator: BaseTranslator {

    /// Transforms the data into a `TransactionsResponse` object and returns
    /// an array of `Transaction` objects.
    ///
    /// - Parameter data: data in binary form
    /// - Throws: a translation error
    /// - Returns: optional array of `Transaction` objects
    internal func fetchResponse(_ data: Data) throws -> [Transaction] {
        return try translate(TransactionsResponse.self, data).histories
    }
}
