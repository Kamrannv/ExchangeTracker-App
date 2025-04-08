//
//  ExchangeRateRepository.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

protocol ExchangeRepository {
    func getRawCryptoRates(ids: [String], vs: [String]) async throws -> [String: [String: Double]]
    func getRawFiatRates(base: String, vs: [String]) async throws -> [String: [String: Double]]
    func getRawAllAssets() async throws -> [String]
}
