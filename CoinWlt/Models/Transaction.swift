//
//  Transaction.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

// MARK: - TransactionsResponse
class TransactionsResponse: Codable {
    let histories: [Transaction]

    init(transactions: [Transaction]) {
        self.histories = transactions
    }
}

// MARK: - Transaction
public struct Transaction: Codable {
    let id, amount, currency: String
    let sender, recipient: String
    let type: TransactionType?

    enum CodingKeys: String, CodingKey {
        case id
        case type = "entry"
        case amount = "amount"
        case currency = "currency"
        case sender = "sender"
        case recipient = "recipient"
    }
}

enum TransactionType: String, Codable {
    case incoming = "incoming"
    case outgoing = "outgoing"
}
