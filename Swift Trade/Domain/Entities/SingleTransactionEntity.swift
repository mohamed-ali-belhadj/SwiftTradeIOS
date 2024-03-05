//
//  SingleTransactionEntity.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 03/03/2024.
//

import Foundation

// MARK: - WelcomeElement

struct SingleTransactionEntity: Identifiable, Equatable {
    var id = UUID().uuidString
    var from, to: String?
    var value: Double?
}
