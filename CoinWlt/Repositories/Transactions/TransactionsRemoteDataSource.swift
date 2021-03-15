//
//  TransactionsRemoteDataSource.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class TransactionsRemoteDataSource: DataSource<Transaction> {
    public override func getAll() throws -> [Transaction] {
        return try TransactionsManager.shared.getAll()
    }
}
