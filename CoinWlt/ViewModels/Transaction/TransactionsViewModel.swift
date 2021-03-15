//
//  TransactionsViewModel.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation

protocol TransactionsViewModelProtocol: class {
    var transactionViewModels: [TransactionViewModel] { get }
    func fetch()
}

protocol TransactionsInterfaceProtocol: class {
    var viewModel: TransactionsViewModelProtocol!  { get set }
}

public class TransactionsViewModel {
    public var repo: BaseRepository<Transaction>?
    var transactions = [TransactionViewModel]()

    init(repo: BaseRepository<Transaction>) {
        self.repo = repo
    }
    
    public func fetch(
        completion: @escaping ([TransactionViewModel]?) -> Void,
        withError: @escaping (Error) -> Void
    ) {
        _ = repo?.getAll()
        .results { (transactions) in
            self.transactions = transactions.map {
                return TransactionViewModel(transaction: $0)
            }
            
            completion(self.transactions)
        }.error { (error) in
            withError(error)
        }
    }

    public func reload() {
        _ = repo?.getAll()
    }
}
