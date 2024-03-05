//
//  MainScreenViewModel.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import Combine

class MainScreenViewModel: ObservableObject {
    @Published var walletDetails: WalletEntity? {
        didSet {
            fetchLastTransactions()
        }
    }
    @Published var lastTransactions: [SingleTransactionEntity]?
    @Published var publicWalletAddress: String = ""

    private var getWalletDetailsUseCase = GetWalletDetailsUseCaseImpl(walletRepository: WalletRepositoryImpl(webService: WebService()))
    private var getLastTransactionsUseCase = GetLastTransactionsUseCaseImpl(walletRepository: WalletRepositoryImpl(webService: WebService()))

    private var getWalletDetailsCancellable: AnyCancellable?
    private var getLastTransactionsCancellable: AnyCancellable?

    func fetchWalletDetails() {
        getWalletDetailsCancellable = getWalletDetailsUseCase.invoke(for: publicWalletAddress)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { walletDetails in
                self.walletDetails = walletDetails
            })
    }

    func fetchLastTransactions() {
        guard let address = walletDetails?.address else {
            return
        }
        getLastTransactionsCancellable = getLastTransactionsUseCase.invoke(for: address)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { transactions in
                self.lastTransactions = transactions
            })
    }
}
