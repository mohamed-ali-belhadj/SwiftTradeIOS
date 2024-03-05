//
//  SingleTransactionTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 04/03/2024.
//

import Foundation
import XCTest
@testable import Swift_Trade

class SingleTransactionDTOTests: XCTestCase {

    func testToDomain_allFields() {
        // Arrange
        let dto = SingleTransactionDTO(from: "Dali", to: "Ilad", value: 100)

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertEqual(entity.from, dto.from)
        XCTAssertEqual(entity.to, dto.to)
        XCTAssertEqual(entity.value, dto.value)

    }

    func testToDomain_missingFields() {
        let dto = SingleTransactionDTO(from: "Dali", to: "Ilad", value: 100)

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertNotNil(entity.value)
        XCTAssertNotNil(entity.from)
        XCTAssertNotNil(entity.to)
    }
}
