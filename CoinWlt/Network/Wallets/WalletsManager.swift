//
//  WalletsManager.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class WalletsManager {

    // Singleton instance
    public static let shared = WalletsManager()

    // A private reference to NetworkManager
    private var network = WalletsNetwork()

    // A private reference to WalletsTranslator
    private var translator = WalletsTranslator()

    init() {
        network = WalletsNetwork()
        translator = WalletsTranslator()
    }

    /// Calls the network layer to fetch the Wallets
    ///
    /// - Throws: @NetworkError
    public func getAll() throws -> [Wallet] {
        do {
            let data = try network.fetch()
            return try translator.fetchResponse(data)
        } catch {
            throw error
        }
    }
}
