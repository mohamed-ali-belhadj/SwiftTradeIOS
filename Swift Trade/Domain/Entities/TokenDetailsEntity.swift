//
//  TokenDetailsEntity.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation

// MARK: - Token
struct TokenDetailsEntity: Hashable, Identifiable {
    static func == (lhs: TokenDetailsEntity, rhs: TokenDetailsEntity) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID().uuidString
    let tokenInfo: TokenInfosEntity?
    let balance: Double?
    let rawBalance: String?
}
