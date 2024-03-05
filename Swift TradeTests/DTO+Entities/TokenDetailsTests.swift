//
//  TokenDetailsTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 04/03/2024.
//

import Foundation
import XCTest
@testable import Swift_Trade

class TokenDetailsTests: XCTestCase {

    func testToDomain_allFields() {
        // Arrange
        let dto = TokenDetailsDTO(tokenInfo: nil, balance: 1.2, rawBalance: "1.2")

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertEqual(entity.balance, dto.balance)
        XCTAssertEqual(entity.rawBalance, dto.rawBalance)

    }

    func testToDomain_missingFields() {
        let dto = TokenDetailsDTO(tokenInfo: nil, balance: 1.4, rawBalance: "1.4")

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertNotNil(entity.rawBalance)
        XCTAssertNotNil(entity.balance)
        XCTAssertNil(entity.tokenInfo)
    }
}
