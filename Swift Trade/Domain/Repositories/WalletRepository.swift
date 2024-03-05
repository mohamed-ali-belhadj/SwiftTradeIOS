//
//  WalletRepository.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import Combine

protocol WalletRepository {
    func getWalletDetails(for address: String) -> AnyPublisher<WalletEntity, Error>
    func getWalletTransactions(for address: String, prefix: Int) -> AnyPublisher<[SingleTransactionEntity], Error>
}
