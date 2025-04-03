//
//  FetchExchangeRatesUseCaseMock.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//

@testable import ExchangeTracker

final class FetchExchangeRatesUseCaseMock: FetchExchangeRatesUseCaseProtocol {
   var result: [ExchangeRate] = []
   var error: Error?

    func execute(for assets: [Asset]) async throws -> [ExchangeRate] {
            if let error = error {
                throw error
            }
            return result
        }
}
