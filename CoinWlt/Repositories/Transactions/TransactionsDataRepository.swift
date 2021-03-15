//
//  TransactionsDataRepository.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class TransactionsDataRepository: BaseRepository<Transaction> {
    public static var shared = TransactionsDataRepository()

    public override init() {
        super.init()

        self.remoteDataSource = TransactionsRemoteDataSource()
    }

    override func getAll() -> BaseRepository<Transaction> {
        return super.getAll()
    }
}
