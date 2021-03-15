//
//  WalletsTranslator.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

internal class WalletsTranslator: BaseTranslator {

    /// Transforms the data into a `WalletsResponse` object and returns
    /// an array of `Wallet` objects.
    ///
    /// - Parameter data: data in binary form
    /// - Throws: a translation error
    /// - Returns: optional array of `Wallet` objects
    internal func fetchResponse(_ data: Data) throws -> [Wallet] {
        return try translate(WalletsResponse.self, data).wallets
    }
}
