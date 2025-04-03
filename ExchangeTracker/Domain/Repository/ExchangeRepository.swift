//
//  ExchangeRateRepository.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

protocol ExchangeRepository {
    func getRates(for assets: [Asset]) async throws -> [ExchangeRate]
    func getAvailableCurrencies() async throws -> [Asset]
}
