//
//  WalletsViewModel.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation
import RxSwift

protocol WalletsViewModelProtocol: class {
    var walletViewModels: [WalletViewModel] { get }
    func fetch()
}

protocol WalletsInterfaceProtocol: class {
    var viewModel: WalletsViewModelProtocol!  { get set }
}

public class WalletsViewModel {
    public var walletsRepo: BaseRepository<Wallet>?

    var wallets = [WalletViewModel]()

    init(repo: BaseRepository<Wallet>) {
        walletsRepo = repo
    }
    
    public func fetch(
        completion: @escaping ([WalletViewModel]?) -> Void,
        withError: @escaping (Error) -> Void
    ) {
        _ = walletsRepo?.getAll()
        .results { (wallets) in
            self.wallets = wallets.map {
                return WalletViewModel(wallet: $0)
            }
            completion(self.wallets)
        }.error { (error) in
            withError(error)
        }
    }

    public func reload() {
        _ = walletsRepo?.getAll()
    }
}
