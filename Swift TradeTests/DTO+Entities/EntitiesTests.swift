//
//  EntitiesTests.swift
//  Swift TradeTests
//
//  Created by Mohamed Ali BELHADJ on 04/03/2024.
//

import Foundation
import XCTest
@testable import Swift_Trade

class EntitiesTests: XCTestCase {

    func testInitialisations() {
        let walletEntity1 = WalletEntity(address: "MyAddress1", cryptoDetails: nil, tokens: nil)
        let walletEntity2 = WalletEntity(address: "MyAddress2", cryptoDetails: nil, tokens: nil)
        let walletEntity22 = WalletEntity(address: "MyAddress2", cryptoDetails: nil, tokens: nil)
        var singleTransactionEntity1 = SingleTransactionEntity(id: "1", from: "DALI", to: "ILADI", value: 1.2)
        let singleTransactionEntity2 = SingleTransactionEntity(id: "3", from: "DALI", to: "ILADI", value: 1.2)
        let tokenEntity = TokenInfosEntity(address: "myAddress", name: "myName", symbol: "NME", website: nil, image: nil)


        //Random Tests..
        XCTAssertEqual(walletEntity1.address, "MyAddress1")
        XCTAssertEqual(walletEntity2, walletEntity22)
        singleTransactionEntity1.id = "3"
        XCTAssertEqual(singleTransactionEntity1.id, "3")
        XCTAssertEqual(singleTransactionEntity1, singleTransactionEntity2)
        XCTAssertEqual(tokenEntity.name, "myName")
    }
}
