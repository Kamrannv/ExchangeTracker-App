//
//  FetchExchangeRatesUseCase.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

protocol FetchExchangeRatesUseCaseProtocol {
    func execute(for assets: [Asset]) async throws -> [ExchangeRate]
}

final class FetchExchangeRatesUseCase: FetchExchangeRatesUseCaseProtocol {
    private let repository: ExchangeRepository

    init(repository: ExchangeRepository) {
        self.repository = repository
    }

    func execute(for assets: [Asset]) async throws -> [ExchangeRate] {
        return try await repository.getRates(for: assets)
    }
}
