//
//  WalletModelTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation
import XCTest
@testable import Swift_Trade

class WalletDTOTests: XCTestCase {

    func testToDomain_allFields() {
        // Arrange
        let address = "someAddress"
        let cryptoDetailsDTO = CryptoDetailsDTO(balance: 300, rawBalance: "300")
        let token1DTO = TokenDetailsDTO(tokenInfo: nil, balance: 100, rawBalance: "100")
        let token2DTO = TokenDetailsDTO(tokenInfo: nil, balance: 200, rawBalance: "200")
        let dto = WalletDTO(address: address, cryptoDetails: cryptoDetailsDTO, tokens: [token1DTO, token2DTO])

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertEqual(entity.address, address)
        XCTAssertEqual(entity.cryptoDetails?.balance, cryptoDetailsDTO.balance)
        XCTAssertEqual(entity.tokens?.count, 2)
        XCTAssertEqual(entity.tokens?[0].balance, token1DTO.balance)
        XCTAssertEqual(entity.tokens?[0].balance, token1DTO.balance)
        XCTAssertEqual(entity.tokens?[1].rawBalance, token2DTO.rawBalance)
        XCTAssertEqual(entity.tokens?[1].balance, token2DTO.balance)
    }

    func testToDomain_missingFields() {
        // Arrange
        let address = "someAddress"
        let dto = WalletDTO(address: address, cryptoDetails: nil, tokens: nil)

        // Act
        let entity = dto.toDomain()

        // Assert
        XCTAssertEqual(entity.address, address)
        XCTAssertNil(entity.cryptoDetails)
        XCTAssertNil(entity.tokens)
    }
}
