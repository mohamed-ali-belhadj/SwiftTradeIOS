//
//  TokenInfos+Decodable.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import SwiftData
// MARK: - TokenInfosDTP

@Model
class TokenInfosDTO: Decodable {
    @Attribute(.unique)
    var symbol: String?
    var tokenAddress: String?
    var name: String?
    var website: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case tokenAddress = "address"
        case name, symbol
        case website
        case image
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.tokenAddress = try values.decodeIfPresent(String.self, forKey: .tokenAddress)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        self.website = try values.decodeIfPresent(String.self, forKey: .website)
        self.image = try values.decodeIfPresent(String.self, forKey: .image)
    }

    init(address: String?, name: String?, symbol: String?, website: String?, image: String?) {
        self.tokenAddress = address
        self.name = name
        self.symbol = symbol
        self.website = website
        self.image = image
    }
}


// MARK: - Mapping to Domain

extension TokenInfosDTO {
    func toDomain() -> TokenInfosEntity {
        TokenInfosEntity(address: tokenAddress, name: name, symbol: symbol, website: website, image: image)
    }
}
