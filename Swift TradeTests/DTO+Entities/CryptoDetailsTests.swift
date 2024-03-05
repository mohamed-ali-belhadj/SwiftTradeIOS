//
//  CryptoDetailsTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
@testable import Swift_Trade
import XCTest

class CryptoDetailsDTOTests: XCTestCase {

    func testToDomain_allFields() {
        // Arrange
        let balance = 7.89
        let rawBalance = "789"
        let dto = CryptoDetailsDTO(balance: balance, rawBalance: rawBalance)

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertEqual(entity.rawBalance, dto.rawBalance)
        XCTAssertEqual(entity.balance, dto.balance)
    }

    func testToDomain_missingFields() {
        // Arrange
        let dto = CryptoDetailsDTO(balance: nil, rawBalance: nil)

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertNil(entity.balance)
        XCTAssertNil(entity.rawBalance)
    }
}
