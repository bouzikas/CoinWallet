//
//  TransactionViewModel.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public struct TransactionViewModel {
    public var id: String
    public var action: String
    public var actionStr: String
    public var amount: String
    public var currency: String
    public var sender: String

    init(transaction: Transaction) {
        self.id = transaction.id
        self.amount = "\(transaction.amount) \(transaction.currency)"
        self.currency = transaction.currency
        self.sender = transaction.sender
        
        switch transaction.type {
        case .incoming:
            self.action = "Received"
            self.actionStr = "You've received a payment"
            break
        case .outgoing:
            self.action = "Sent"
            self.actionStr = "You've cashed out to " + transaction.recipient
            break
        default:
            self.action = "Action"
            self.actionStr = "Some action"
        }
    }
}
