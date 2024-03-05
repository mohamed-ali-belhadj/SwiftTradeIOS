//
//  CryptoDetails+Decodable.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import SwiftData
// MARK: - CryptoDetailsDTO

@Model
class CryptoDetailsDTO: Decodable {
    @Attribute(.unique) var id = UUID().uuidString
    var balance: Double?
    var rawBalance: String?

    enum CodingKeys: String, CodingKey {
        case balance
        case rawBalance
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.balance = try values.decodeIfPresent(Double.self, forKey: .balance)
        self.rawBalance = try values.decodeIfPresent(String.self, forKey: .rawBalance)
    }
    
    init(balance: Double?, rawBalance: String?) {
        self.balance = balance
        self.rawBalance = rawBalance
    }
}

// MARK: - Mapping to Domain

extension CryptoDetailsDTO {
    func toDomain() -> CryptoDetailsEntity {
        CryptoDetailsEntity(balance: balance, rawBalance: rawBalance)
    }
}
