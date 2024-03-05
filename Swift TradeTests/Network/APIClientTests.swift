//
//  APIClientTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
@testable import Swift_Trade
import Combine
import XCTest

class URLSessionAPIClientTests: XCTestCase {

    // Mock endpoint for testing
    enum MockEndpoint: APIEndpoint {
        case getLastTransactions(_ address: String, prefix: Int = 3)

        var cachePolicy: URLRequest.CachePolicy {
            switch self {
            case .getLastTransactions:
                return .reloadIgnoringLocalAndRemoteCacheData
            }
        }


        var baseURL: URL {
            return URL(string: WebServiceConstants.baseURL)!
        }

        var path: String {
            switch self {
            case .getLastTransactions(let address, prefix: _):
                return "getAddressTransactions/\(address)"
            }
        }

        var method: HTTPMethod {
            switch self {
            case .getLastTransactions:
                return .get
            }
        }

        var parameters: [String: Any]? {
            switch self {
            case .getLastTransactions(_, prefix: let prefix):
                return [
                    "apiKey": "freekey",
                    "limit": "\(prefix)"]
            }
        }
    }


    // Mock endpoint for testing
    class WebServiceMock: URLSessionAPIClient<MockEndpoint> {
        func getMethodMock(_ endpoint: MockEndpoint) -> AnyPublisher<[SingleTransactionDTO], Error> {
            super.request(endpoint)
        }
    }

    func test_request_successfulResponse_completesSuccessfully() {
        let client = WebServiceMock()

        let expectation = self.expectation(description: "Successful response expectation")

        client.getMethodMock(.getLastTransactions("0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045", prefix: 3))
            .sink(receiveCompletion: { completion in
                if case .finished = completion {
                    expectation.fulfill()
                }
            }, receiveValue: { receivedValue in
                XCTAssertEqual(receivedValue.count, 3)

            })
            .store(in: &cancellables)

        URLSession.shared.getAllTasks { tasks in
            tasks.first?.cancel() // Cancel the actual network request to avoid unnecessary network calls during tests
        }

        self.wait(for: [expectation], timeout: 4.0)
    }

    private var cancellables = Set<AnyCancellable>()

    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
}

struct EmptyResponse: Decodable {}
