//
//  GetWalletUseCaseTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import XCTest
import Combine
@testable import Swift_Trade

class GetWalletDetailsUseCaseImplTests: XCTestCase {

    private var walletRepository: MockWalletRepository!
    private var useCase: GetWalletDetailsUseCaseImpl!

    override func setUp() {
        super.setUp()
        walletRepository = MockWalletRepository()
        useCase = GetWalletDetailsUseCaseImpl(walletRepository: walletRepository)
    }

    func testInvoke_success() {
        // Arrange
        let expectedWallet = GetWalletDetailsUseCaseImplTests.createWalletEntity()
        walletRepository.getWalletDetailsResult = .success(expectedWallet)

        // Act
        let expectation = XCTestExpectation(description: "Fetch wallet details")
        useCase.invoke(for: "anyAddress")
            .sink { completion in
                // Assert
                if case .finished = completion {
                    expectation.fulfill()
                }
            } receiveValue: { wallet in
                XCTAssertEqual(wallet, expectedWallet)
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    func testInvoke_failure() {
        // Arrange
        let expectedError = APIError.unknown
        walletRepository.getWalletDetailsResult = .failure(expectedError)

        // Act
        let expectation = XCTestExpectation(description: "Fetch wallet details")
        useCase.invoke(for: "anyAddress")
            .sink(receiveCompletion: { completion in
                // Assert
                if case let .failure(error) = completion {
                    XCTAssertEqual(error as? APIError, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in

            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1)
    }

    // Define a mock repository for isolation
    private class MockWalletRepository: WalletRepository {
        var getWalletDetailsResult: Result<WalletEntity, Error> = .success(GetWalletDetailsUseCaseImplTests.createWalletEntity())
        var getWalletTransactionsResult: Result<[SingleTransactionEntity], Error> = .success([])

        func getWalletTransactions(for address: String, prefix: Int) -> AnyPublisher<[Swift_Trade.SingleTransactionEntity], Error> {
            Future { promise in
                promise(self.getWalletTransactionsResult)
            }.eraseToAnyPublisher()
        }


        func getWalletDetails(for address: String) -> AnyPublisher<WalletEntity, Error> {
            Future { promise in
                promise(self.getWalletDetailsResult)
            }.eraseToAnyPublisher()
        }
    }

    // Private helper for creating a sample wallet entity
    static func createWalletEntity() -> WalletEntity {
        WalletEntity(address: "", cryptoDetails: nil, tokens: [])
        // Initialize a WalletEntity with appropriate values for testing
    }

    private var cancellables = Set<AnyCancellable>()
}
