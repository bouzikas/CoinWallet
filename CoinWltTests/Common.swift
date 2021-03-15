//
//  Common.swift
//  CoinWltTests
//
//  Created by Dimitris Bouzikas on 14/3/21.
//

import Foundation

@testable import CoinWlt

internal class Common {
    public static let shared = Common()

    func getJsonData(mockName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: mockName, ofType: "json")

        let url = URL(fileURLWithPath: filePath!)
        do {
            let jsonData = try Data(contentsOf: url)
            return jsonData
        } catch {
            return nil
        }
    }
}
