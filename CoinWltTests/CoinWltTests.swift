//
//  CoinWltTests.swift
//  CoinWltTests
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import XCTest
@testable import CoinWlt

class CoinWltTests: XCTestCase {
    
    let waTranslator = WalletsTranslator()
    let trTranslator = TransactionsTranslator()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWalletTranslation() throws {
        let mockJsonData = Common.shared.getJsonData(mockName: "wallets-200")!
        let response = try waTranslator.fetchResponse(mockJsonData)
        
        XCTAssert((response as Any) is Array<Wallet>)
    }
    
    func testWallet_429_Translation() throws {
        let mockJsonData = Common.shared.getJsonData(mockName: "wallets-429")!
        
        XCTAssertThrowsError(try waTranslator.fetchResponse(mockJsonData), "Error") { (error) in
            XCTAssertEqual(ErrorSerializer.networkError(error: error), "Request has been throttled")
        }
    }
    
    func testTransactionTranslation() throws {
        let mockJsonData = Common.shared.getJsonData(mockName: "transactions-200")!
        let response = try trTranslator.fetchResponse(mockJsonData)
        
        XCTAssert((response as Any) is Array<Transaction>)
    }
    
    func testTransaction_429_Translation() throws {
        let mockJsonData = Common.shared.getJsonData(mockName: "transactions-429")!
        
        XCTAssertThrowsError(try trTranslator.fetchResponse(mockJsonData), "Error") { (error) in
            XCTAssertEqual(ErrorSerializer.networkError(error: error), "Request has been throttled")
        }
    }
    
    func testWalletsViewModel() {
        let exp = expectation(description: "WalletsViewModel")
        var catchedResponse: [WalletViewModel]?
        var catchedError: Error?
        let walletsViewModel = WalletsViewModel(repo: WalletsDataRepository())
        
        walletsViewModel.fetch { (wallets) in
            catchedResponse = wallets
            exp.fulfill()
        } withError: { (error) in
            catchedError = error
        }
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertNil(catchedError)
            XCTAssertNotNil(catchedResponse)
        }
    }
    
    func testTransactionsViewModel() {
        let exp = expectation(description: "TransactionsViewModel")
        var catchedResponse: [TransactionViewModel]?
        var catchedError: Error?
        let transactionsViewModel = TransactionsViewModel(repo: TransactionsDataRepository())
        
        transactionsViewModel.fetch { (transactions) in
            catchedResponse = transactions
            exp.fulfill()
        } withError: { (error) in
            catchedError = error
        }
        
        waitForExpectations(timeout: 2) { _ in
            XCTAssertNil(catchedError)
            XCTAssertNotNil(catchedResponse)
        }
    }
    
    func testExpectedWalletsGetUrl() {
        let request = WalletsRequestBuilder.get

        guard let url = request.urlRequest?.url else {
            XCTFail(); return
        }

        let urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: true)

        XCTAssertEqual(urlComponets?.host, "www.amock.io")
        XCTAssertEqual(urlComponets?.path, "/api/dbouzikas/wallets")
    }
    
    func testExpectedTransactionsGetUrl() {
        let request = TransactionsRequestBuilder.get

        guard let url = request.urlRequest?.url else {
            XCTFail(); return
        }

        let urlComponets = URLComponents(url: url, resolvingAgainstBaseURL: true)

        XCTAssertEqual(urlComponets?.host, "www.amock.io")
        XCTAssertEqual(urlComponets?.path, "/api/dbouzikas/histories")
    }
    
    func testWalletLoaded() {
        let wallet = Wallet(id: "1", name: "name", balance: "123.5")
        XCTAssertEqual(wallet.id, "1")
        XCTAssertEqual(wallet.name, "name")
        XCTAssertEqual(wallet.balance, "123.5")
    }
    
    func testTransactionLoaded() {
        let transactionResp = TransactionsResponse(transactions: [
            Transaction(
                id: "1",
                amount: "5",
                currency: "BTC",
                sender: "You",
                recipient: "Me",
                type: .incoming
            ),
            Transaction(
                id: "2",
                amount: "5",
                currency: "BTC",
                sender: "You",
                recipient: "Me",
                type: .incoming
            )
        ])
        
        XCTAssert((transactionResp.histories as Any) is Array<Transaction>)
    }
}
