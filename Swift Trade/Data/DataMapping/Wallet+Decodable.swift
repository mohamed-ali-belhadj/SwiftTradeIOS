//
//  Wallet+Decodable.swift
//  Swift Trade
//
//  Created by Mohamed Ali BELHADJ on 02/03/2024.
//

import Foundation
import SwiftData

// MARK: - WalletDTO

@Model
class WalletDTO: Decodable {
    @Attribute(.unique)
    var address: String?
    var cryptoDetails: CryptoDetailsDTO?
    var tokens: [TokenDetailsDTO]?

    enum CodingKeys: String, CodingKey {
        case address
        case cryptoDetails = "ETH"
        case tokens
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try values.decodeIfPresent(String.self, forKey: .address)
        self.cryptoDetails = try values.decodeIfPresent(CryptoDetailsDTO.self, forKey: .cryptoDetails)
        self.tokens = try values.decodeIfPresent([TokenDetailsDTO].self, forKey: .tokens)
    }

    init(address: String?, cryptoDetails: CryptoDetailsDTO?, tokens: [TokenDetailsDTO]?) {
        self.address = address
        self.cryptoDetails = cryptoDetails
        self.tokens = tokens
    }
}

// MARK: - Mapping to Domain

extension WalletDTO {
    func toDomain() -> WalletEntity {
        WalletEntity(address: address, cryptoDetails: cryptoDetails?.toDomain(), tokens: tokens?.map{ $0.toDomain() })
    }
}
