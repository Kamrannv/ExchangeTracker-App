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

    var receivedCurrentlySelected: [Asset] = []

       func execute(currentlySelected: [Asset]) async throws -> [Asset] {
           receivedCurrentlySelected = currentlySelected
           if let error { throw error }
           return result
       }
}
