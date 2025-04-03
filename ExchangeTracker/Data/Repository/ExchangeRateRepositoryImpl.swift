//
//  ExchangeRateRepositoryImpl.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

final class ExchangeRepositoryImpl: ExchangeRepository {
    private let networkService: ExchangeNetworkServiceDelegate

    init(networkService: ExchangeNetworkServiceDelegate) {
        self.networkService = networkService
    }

    func getRates(for assets: [Asset]) async throws -> [ExchangeRate] {
        return try await networkService.fetchRates(for: assets)
    }
    
    func getAvailableCurrencies() async throws -> [Asset] {
        try await networkService.fetchAvailableCurrencies()
      }
}
