//
//  WebService.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import Combine

class WebService: URLSessionAPIClient<CryptoEndpoint> {
    func getWalletDetails(_ endpoint: CryptoEndpoint) -> AnyPublisher<WalletDTO, Error> {
        super.request(endpoint)
    }

    func getLastTransactions(_ endpoint: CryptoEndpoint) -> AnyPublisher<[SingleTransactionDTO], Error> {
        super.request(endpoint)
    }
}
