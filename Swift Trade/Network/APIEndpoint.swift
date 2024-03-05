//
//  APIEndpoint.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension APIEndpoint {
    var headers: [String: String]? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }
}
