//
//  CryptoEndpoint.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation

enum CryptoEndpoint: APIEndpoint {
    case getWalletDetails(_ address: String)
    case getLastTransactions(_ address: String, prefix: Int = 5)

    var baseURL: URL {
        return URL(string: WebServiceConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .getWalletDetails(let address):
            return "getAddressInfo/\(address)"
        case .getLastTransactions(let address, prefix: _):
            return "getAddressTransactions/\(address)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getWalletDetails:
            return .get
        case .getLastTransactions(_, prefix: _):
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getWalletDetails:
            return ["apiKey": "freekey"]
        case .getLastTransactions(_, prefix: let prefix):
            return [
                "apiKey": "freekey",
                "limit": "\(prefix)"]
        }
    }

    var cachePolicy: URLRequest.CachePolicy {
        switch self {
        case .getWalletDetails( _):
            return .returnCacheDataElseLoad
        case .getLastTransactions( _, _):
            return .reloadIgnoringLocalAndRemoteCacheData
        }
    }
}
