//
//  TokenDetails+Decodable.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import SwiftData

// MARK: - TokenDTO

@Model
class TokenDetailsDTO: Decodable {
    @Attribute(.unique)
    let id = UUID().uuidString
    var tokenInfo: TokenInfosDTO?
    var balance: Double?
    var rawBalance: String?

    enum CodingKeys: String, CodingKey {
        case tokenInfo
        case balance
        case rawBalance
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.tokenInfo = try values.decodeIfPresent(TokenInfosDTO.self, forKey: .tokenInfo)
        self.balance = try values.decodeIfPresent(Double.self, forKey: .balance)
        self.rawBalance = try values.decodeIfPresent(String.self, forKey: .rawBalance)
    }

    init(tokenInfo: TokenInfosDTO?, balance: Double?, rawBalance: String?) {
        self.tokenInfo = tokenInfo
        self.balance = balance
        self.rawBalance = rawBalance
    }
}

// MARK: - Mapping to Domain

extension TokenDetailsDTO {
    func toDomain() -> TokenDetailsEntity {
        TokenDetailsEntity(tokenInfo: tokenInfo?.toDomain(), balance: balance, rawBalance: rawBalance)
    }
}
