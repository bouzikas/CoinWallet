//
//  WalletsDataRepository.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

public class WalletsDataRepository: BaseRepository<Wallet> {
    public static var shared = WalletsDataRepository()

    public override init() {
        super.init()

        self.remoteDataSource = WalletsRemoteDataSource()
    }

    override func getAll() -> BaseRepository<Wallet> {
        return super.getAll()
    }
}
