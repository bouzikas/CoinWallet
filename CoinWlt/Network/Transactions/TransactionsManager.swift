//
//  TransactionsManager.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class TransactionsManager {

    // Singleton instance
    public static let shared = TransactionsManager()

    // A private reference to Network
    private var network = TransactionsNetwork()

    // A private reference to Translator
    private var translator = TransactionsTranslator()

    init() {
        network = TransactionsNetwork()
        translator = TransactionsTranslator()
    }

    /// Calls the network layer to fetch the Transactions
    ///
    /// - Throws: @NetworkError
    public func getAll() throws -> [Transaction] {
        do {
            let data = try network.fetch()
            return try translator.fetchResponse(data)
        } catch {
            throw error
        }
    }
}
