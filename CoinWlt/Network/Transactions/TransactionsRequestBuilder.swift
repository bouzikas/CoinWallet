//
//  TransactionsRequestBuilder.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 13/3/21.
//

import Foundation
import Alamofire

enum TransactionsRequestBuilder: URLRequestConvertible {
    case get

    private var httpMethod: HTTPMethod {
        // here we can distinguish return value
        // by case (for all CRUD - same as path)
        return .get
    }

    private var baseUrl: URL {
        switch self {
        case .get:
            return try! Constants.Api.baseUrl.asURL()
        }
    }

    private var path: String {
        switch self {
        case .get:
            return "/histories"
        }
    }

    private var parameters: [String: Any] {
        switch self {
        case .get:
            return [:]
        }
    }

    internal func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))

        request = try URLEncoding.default.encode(request, with: parameters)
        request.httpMethod = httpMethod.rawValue

        return request
    }
}
