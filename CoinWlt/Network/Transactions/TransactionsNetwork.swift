//
//  TransactionsNetwork.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

internal class TransactionsNetwork: BaseNetwork {

    /// Fetches the transactions history
    ///
    /// - Throws: a `NetworkError` if any
    /// - Returns: data of the response
    internal func fetch() throws -> Data {
        return try request(TransactionsRequestBuilder.get)
    }
}
