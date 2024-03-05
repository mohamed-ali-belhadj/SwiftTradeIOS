//
//  WalletRepositoryImpl.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import Combine

final class WalletRepositoryImpl {

    private let webService: WebService

    init(webService: WebService) {
        self.webService = webService
    }
}

extension WalletRepositoryImpl: WalletRepository {
    func getWalletDetails(for address: String) -> AnyPublisher<WalletEntity, Error> {
        webService.getWalletDetails(.getWalletDetails(address))
            .map({
                DatabaseService.shared.save(model: $0)
                return $0.toDomain()
            })
            .eraseToAnyPublisher()
    }

    func getWalletTransactions(for address: String, prefix: Int) -> AnyPublisher<[SingleTransactionEntity], Error> {
        webService.getLastTransactions(.getLastTransactions(address, prefix: prefix))
            .map({ $0.map({ $0.toDomain() })})
            .eraseToAnyPublisher()
    }
}
