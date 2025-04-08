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
    
 
    var receivedAssets: [Asset] = []
    var receivedPrevious: [String: Double] = [:]

    func execute(for assets: [Asset], previous: [String: Double]) async throws -> [ExchangeRate] {
        receivedAssets = assets
        receivedPrevious = previous
        
        if let error = error {
            throw error
        }
        return result
    }
}
