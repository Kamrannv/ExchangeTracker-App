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
    
    func getRawCryptoRates(ids: [String], vs: [String]) async throws -> [String: [String: Double]] {
        try await networkService.fetchRawCryptoRates(ids: ids, vsCurrencies: vs)
    }
    
    func getRawFiatRates(base: String, vs: [String]) async throws -> [String: [String: Double]] {
        try await networkService.fetchRawFiatRates(base: base, vsCurrencies: vs)
    }
    
    func getRawAllAssets() async throws -> [String] {
        try await networkService.fetchRawAllAssets()
    }
}
