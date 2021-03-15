//
//  Wallet.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

// MARK: - WalletsResponse
class WalletsResponse: Codable {
    let wallets: [Wallet]

    init(wallets: [Wallet]) {
        self.wallets = wallets
    }
}

// MARK: - Wallet
public class Wallet: Codable {
    let id, name, balance: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "wallet_name"
        case balance
    }

    init(id: String, name: String, balance: String) {
        self.id = id
        self.name = name
        self.balance = balance
    }
}
