//
//  GetLastTransactionsUseCaseTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import XCTest
import Combine
@testable import Swift_Trade

class GetLastTransactionsUseCaseImplTests: XCTestCase {

    private var walletRepository: MockWalletRepository!
    private var useCase: GetLastTransactionsUseCaseImpl!

    override func setUp() {
        super.setUp()
        walletRepository = MockWalletRepository()
        useCase = GetLastTransactionsUseCaseImpl(walletRepository: walletRepository)
    }

    func testInvoke_success() {
        // Arrange
        let expectedTransactions = GetLastTransactionsUseCaseImplTests.createTransactions()
        walletRepository.getWalletTransactionsResult = .success(expectedTransactions)

        // Act
        let expectation = XCTestExpectation(description: "Fetch wallet details")
        useCase.invoke(for: "anyAddress", prefix: 1)
            .sink { completion in
                // Assert
                if case .finished = completion {
                    expectation.fulfill()
                }
            } receiveValue: { wallet in
                XCTAssertEqual(wallet, expectedTransactions)
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 3)
    }

    func testInvoke_failure() {
        // Arrange
        let expectedError = APIError.unknown
        walletRepository.getWalletTransactionsResult = .failure(expectedError)

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

    // Private helper for creating a sample transactions
    static func createTransactions() -> [SingleTransactionEntity] {
        []
        // Initialize a WalletEntity with appropriate values for testing
    }

    private var cancellables = Set<AnyCancellable>()
}
