//
//  WalletEntity.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation

// MARK: - WalletEntity

struct WalletEntity: Equatable {
    static func == (lhs: WalletEntity, rhs: WalletEntity) -> Bool {
        lhs.address == rhs.address
    }

    let address: String?
    let cryptoDetails: CryptoDetailsEntity?
    let tokens: [TokenDetailsEntity]?
}
