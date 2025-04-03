//
//  Availa.swift
//  ExchangeTracker
//
//  Created by Kamran on 03.04.25.
//
import Foundation


struct AvailableCurrencies: Codable {
    let data: [String: String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.data = try container.decode([String: String].self)
    }
}

extension AvailableCurrencies {
    func toDomain() -> [Asset] {
        data.map {
            Asset(id: $0.key, name: $0.key, type: $0.key == "BTC" ? .crypto : .fiat)
        }.sorted { $0.name < $1.name }
    }
}

