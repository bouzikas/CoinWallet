//
//  WalletViewModel.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public struct WalletViewModel {
    public var id: String
    public var name: String
    public var balance: String
    public var currencyIcon: String
    
    init(wallet: Wallet) {
        self.id = wallet.id
        self.name = wallet.name
        self.balance = wallet.balance
        
        if let type = Currency(rawValue: self.name) {
            currencyIcon = type.rawValue.lowercased()
        } else {
            currencyIcon = "blockchain"
        }
    }
}

enum Currency: String, Codable {
    case btc = "BTC"
    case eth = "ETH"
    case usd = "USD"
}
