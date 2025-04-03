//
//  ExchangeRateResponse.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}

extension ExchangeRateResponse {
    func toDomain() -> [ExchangeRate] {
            rates.map { code, value in
                ExchangeRate(
                    id: code,
                    value: value,
                    percentageChange: Double.random(in: -2...2)
                )
            }
        }
}
