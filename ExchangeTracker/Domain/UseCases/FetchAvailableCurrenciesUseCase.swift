//
//  FetchAvailableCurrenciesUseCase.swift
//  ExchangeTracker
//
//  Created by Kamran on 03.04.25.
//

protocol FetchAvailableCurrenciesUseCaseProtocol {
    func execute() async throws -> [Asset]
}

final class FetchAvailableCurrenciesUseCase: FetchAvailableCurrenciesUseCaseProtocol {
    private let repository: ExchangeRepository
    init(repository: ExchangeRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Asset] {
        try await repository.getAvailableCurrencies()
    }
}
