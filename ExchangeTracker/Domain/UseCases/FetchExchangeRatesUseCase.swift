//
//  FetchExchangeRatesUseCase.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

protocol FetchExchangeRatesUseCaseProtocol {
    func execute(for assets: [Asset], previous: [String: Double]) async throws -> [ExchangeRate]
}

final class FetchExchangeRatesUseCase: FetchExchangeRatesUseCaseProtocol {
    private let repository: ExchangeRepository
    private let factory: ExchangeRateFactoryProtocol

    init(repository: ExchangeRepository, factory: ExchangeRateFactoryProtocol) {
            self.repository = repository
            self.factory = factory
        }

    func execute(for assets: [Asset], previous: [String: Double]) async throws -> [ExchangeRate] {
           let cryptoAssets = assets.filter { $0.type == .crypto }
           let fiatAssets = assets.filter { $0.type == .fiat }

           var result: [ExchangeRate] = []

           if !cryptoAssets.isEmpty {
               let ids = cryptoAssets.map { $0.id.lowercased() }
               let cryptoRates = try await repository.getRawCryptoRates(ids: ids, vs: ["usd"])
               result += factory.createCryptoRates(from: cryptoRates, previous: previous)
           }

           if !fiatAssets.isEmpty {
               let vs = fiatAssets.map { $0.id.lowercased() }
               let fiatRates = try await repository.getRawFiatRates(base: "usd", vs: vs)
               result += factory.createFiatRates(from: fiatRates, previous: previous)
           }

           return result
       }

}
