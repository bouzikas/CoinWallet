//
//  WalletsNetwork.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

internal class WalletsNetwork: BaseNetwork {

    /// Fetches the wallets
    ///
    /// - Throws: a `NetworkError` if any
    /// - Returns: data of the response
    internal func fetch() throws -> Data {
        return try request(WalletsRequestBuilder.get)
    }
}
