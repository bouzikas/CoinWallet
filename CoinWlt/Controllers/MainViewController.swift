//
//  MainViewController.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import UIKit
import SkeletonView

class MainViewController: UIViewController {
    lazy private var walletsViewModel = makeWalletsViewModel()
    lazy private var transactionsViewModel = makeTransactionsViewModel()
    
    private var wallets = [WalletViewModel]()
    private var transactions = [TransactionViewModel]()
    
    @IBOutlet weak var walletsTableConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var walletsTableView: UITableView! {
        didSet {
            walletsTableView.register(
                UINib(nibName: "WalletCell", bundle: nil),
                forCellReuseIdentifier: WalletCell.reuseIdentifier
            )
        }
    }
    
    @IBOutlet weak var transactionsTableView: UITableView! {
        didSet {
            transactionsTableView.register(
                UINib(nibName: "TransactionCell", bundle: nil),
                forCellReuseIdentifier: TransactionCell.reuseIdentifier
            )
        }
    }
    
    private(set) lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        return control
    }()
}

// MARK: - Main lifecycle
extension MainViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Dashboard"
        
        scrollView.refreshControl = refreshControl
        
        configureTableViews()
        bindFetches()
    }
    
    func configureTableViews() {
        walletsTableView.isSkeletonable = true
        transactionsTableView.isSkeletonable = true
        
        // remove extra lines from the bottom
        walletsTableView.tableFooterView = UIView()
        transactionsTableView.tableFooterView = UIView()
    }
}

// MARK: - Setup binds
extension MainViewController {
    fileprivate func bindFetches() {
        bindFetchWallets()
        bindFetchTransactions()
    }
    
    fileprivate func bindFetchWallets() {
        walletsStartLoading()
        walletsViewModel.fetch { [weak self] (wallets) in
            guard let self = self, let wallets = wallets else { return }

            // Delaying the fetch to see the loading state
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.wallets = wallets
                self.walletsTableView.hideSkeleton()
                self.walletsTableView.reloadData()
                self.refreshControl.endRefreshing()
                self.walletsTableConstraint.constant = CGFloat(self.wallets.count * 70)
            }
        } withError: { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.walletsTableView.hideSkeleton()
                self.refreshControl.endRefreshing()
                let errorStr = ErrorSerializer.networkError(error: error)
                self.walletsTableView.setEmptyView(
                    message: "Wallets Load Failed: " + errorStr,
                    doRepeat: false
                )
            }
        }
    }
    
    fileprivate func bindFetchTransactions() {
        transactionStartLoading()
        transactionsViewModel.fetch { [weak self] (transactions) in
            guard let self = self, let transactions = transactions else { return }
            
            // Delaying the fetch to see the loading state
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                self.transactions = transactions
                self.transactionsTableView.hideSkeleton()
                self.transactionsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        } withError: { (error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.transactionsTableView.hideSkeleton()
                self.refreshControl.endRefreshing()
                let errorStr = ErrorSerializer.networkError(error: error)
                self.transactionsTableView.setEmptyView(
                    message: "Transactions Load Failed: " + errorStr,
                    doRepeat: false
                )
            }
        }
    }
}

// MARK: - Loading
extension MainViewController {
    fileprivate func walletsStartLoading() {
        wallets.removeAll()
        walletsTableView.restore()
        walletsTableView.showAnimatedGradientSkeleton()
    }
        
    fileprivate func transactionStartLoading() {
        transactions.removeAll()
        transactionsTableView.restore()
        transactionsTableView.showAnimatedGradientSkeleton()
    }
}

// MARK: - Selectors
extension MainViewController {
    @objc func reloadData() {
        walletsStartLoading()
        transactionStartLoading()
        
        self.walletsViewModel.reload()
        self.transactionsViewModel.reload()
    }
}

// MARK: - Table view data source
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == walletsTableView {
            return wallets.count
        }

        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == walletsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: WalletCell.reuseIdentifier) as! WalletCell
            cell.item = wallets[indexPath.row]
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.reuseIdentifier) as! TransactionCell
        cell.item = transactions[indexPath.row]
        return cell
    }
}

// MARK: - Table view delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = Bundle.main.loadNibNamed(
            "TableHeader",
            owner: self,
            options: nil
        )?.first as! TableHeader

        cell.headerTitleLabel.text = tableView == walletsTableView ? "My Wallets" : "History"

        return cell
    }
}

// MARK: - SkeletonView data source
extension MainViewController: SkeletonTableViewDataSource {
    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 1
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        if skeletonView == walletsTableView {
            return WalletCell.reuseIdentifier
        }
        return TransactionCell.reuseIdentifier
    }
}

// MARK: - SkeletonView view delegate
extension MainViewController: SkeletonTableViewDelegate {
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        identifierForHeaderInSection section: Int
    ) -> ReusableHeaderFooterIdentifier? {
        return "TableHeader"
    }
}

// MARK: - ViewModel initializers
extension MainViewController {
    private func makeWalletsViewModel() -> WalletsViewModel {
        return WalletsViewModel(repo: WalletsDataRepository())
    }

    private func makeTransactionsViewModel() -> TransactionsViewModel {
        return TransactionsViewModel(repo: TransactionsDataRepository())
    }
}
