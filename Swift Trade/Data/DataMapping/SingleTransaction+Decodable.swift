//
//  SingleTransaction+Decodable.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation

struct SingleTransactionDTO: Decodable {
    let from, to: String?
    let value: Double?
}

// MARK: - Mapping to Domain

extension SingleTransactionDTO {
    func toDomain() -> SingleTransactionEntity {
        SingleTransactionEntity(from: from, to: to, value: value)
    }
}
