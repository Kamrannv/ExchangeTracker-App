//
//  ExchangeRateFactory.swift
//  ExchangeTracker
//
//  Created by Kamran on 08.04.25.
//

protocol ExchangeRateFactoryProtocol {
    func createCryptoRates(from data: [String: [String: Double]], previous: [String: Double]) -> [ExchangeRate]
    func createFiatRates(from data: [String: [String: Double]], previous: [String: Double]) -> [ExchangeRate]
}

final class ExchangeRateFactory: ExchangeRateFactoryProtocol {
    func createCryptoRates(from data: [String: [String: Double]], previous: [String: Double]) -> [ExchangeRate] {
        data.compactMap { (id, value) in
            guard let usd = value["usd"] else { return nil }
            let change = ExchangeRateCalculator.calculatePercentageChange(current: usd, previous: previous[id])
            return ExchangeRate(id: id, value: usd, percentageChange: change)
        }
    }

    func createFiatRates(from data: [String: [String: Double]], previous: [String: Double]) -> [ExchangeRate] {
        guard let usdBlock = data["usd"] else { return [] }

        return usdBlock.map { (key, value) in
            let actual = 1 / value
            let change = ExchangeRateCalculator.calculatePercentageChange(current: actual, previous: previous[key])
            return ExchangeRate(id: key, value: actual, percentageChange: change)
        }
    }
}
