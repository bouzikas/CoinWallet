//
//  BaseNetwork.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation
import Alamofire

internal class BaseNetwork {

    /// Handler for our request session
    internal let session: Session!

    /// Initialize some basic session restrictions
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30

        session = Session(configuration: config)
    }

    /// Alamofire request wrapper with Async await approach
    ///
    /// - Parameter urlRequest: Request Builder
    /// - Throws: An error of type `NetworkError`
    /// - Returns: Data
    internal func request(_ urlRequest: URLRequestConvertible) throws -> Data {

        var data: Data?
        var error: NetworkError?

        let semaphore = DispatchSemaphore(value: 0)

        session.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success:
                if let jsonData = response.data {
                    data = jsonData
                } else {
                    error = NetworkError.badFormat
                }
            case let .failure(err):
                error = NetworkError.failed(error: err)
            }

            semaphore.signal()
        }

        _ = semaphore.wait(timeout: .distantFuture)

        guard data != nil, error == nil else {
            throw error!
        }

        return data!
    }
}
