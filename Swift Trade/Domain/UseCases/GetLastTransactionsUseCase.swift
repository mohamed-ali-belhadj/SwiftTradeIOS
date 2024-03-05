//
//  GetLastTransactionsUseCase.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import Combine

protocol GetLastTransactionsUseCase {
    func invoke(for address: String, prefix: Int) -> AnyPublisher<[SingleTransactionEntity], Error>
}

final class GetLastTransactionsUseCaseImpl: GetLastTransactionsUseCase {
    var walletRepository: WalletRepository

    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }

    func invoke(for address: String, prefix: Int = 5) -> AnyPublisher<[SingleTransactionEntity], Error> {
        walletRepository.getWalletTransactions(for: address, prefix: prefix)
    }
}
