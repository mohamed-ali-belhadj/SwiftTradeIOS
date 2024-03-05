//
//  GetWalletDetailsUseCase.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import Combine

protocol GetWalletDetailsUseCase {
    func invoke(for address: String) -> AnyPublisher<WalletEntity, Error>
}

final class GetWalletDetailsUseCaseImpl: GetWalletDetailsUseCase {
    var walletRepository: WalletRepository

    init(walletRepository: WalletRepository) {
        self.walletRepository = walletRepository
    }

    func invoke(for address: String) -> AnyPublisher<WalletEntity, Error> {
        walletRepository.getWalletDetails(for: address)
    }
}
