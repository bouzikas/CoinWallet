//
//  WalletsRemoteDataSource.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class WalletsRemoteDataSource: DataSource<Wallet> {
    public override func getAll() throws -> [Wallet] {
        return try WalletsManager.shared.getAll()
    }
}
