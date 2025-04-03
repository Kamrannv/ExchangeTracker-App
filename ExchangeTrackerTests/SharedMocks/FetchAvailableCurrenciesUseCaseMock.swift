//
//  FetchAvailableCurrenciesUseCaseMock.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//
@testable import ExchangeTracker

final class FetchAvailableCurrenciesUseCaseMock: FetchAvailableCurrenciesUseCaseProtocol {
    var result: [Asset] = []
    var error: Error?

    func execute() async throws -> [Asset] {
        if let error { throw error }
        return result
    }
}
