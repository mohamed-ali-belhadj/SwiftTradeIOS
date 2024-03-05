//
//  TokenInfosEntity.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation

// MARK: - TokenInfosEntity
struct TokenInfosEntity: Hashable {
    static func == (lhs: TokenInfosEntity, rhs: TokenInfosEntity) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID().uuidString
    let address, name: String?
    let symbol: String?
    let website: String?
    let image: String?
}
