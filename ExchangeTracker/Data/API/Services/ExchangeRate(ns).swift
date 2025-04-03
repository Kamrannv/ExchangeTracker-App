//
//  ExchangeRate(ns).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

protocol ExchangeNetworkServiceDelegate {
    func fetchRates(for assets: [Asset]) async throws -> [ExchangeRate]
    func fetchAvailableCurrencies() async throws -> [Asset]
}

public class ExchangeNetworkService: ExchangeNetworkServiceDelegate {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
            self.client = client
        }
    
    func fetchRates(for assets: [Asset]) async throws -> [ExchangeRate] {
        let endpoint = ExchangeEndPoints.currencyRate(assets)
            let response = try await client.request(endpoint, ExchangeRateResponse.self)
            return response.toDomain()
        }
    
    func fetchAvailableCurrencies() async throws -> [Asset] {
           let endpoint = ExchangeEndPoints.currencies
        let response = try await client.request(endpoint, AvailableCurrencies.self)
           return response.toDomain()
       }
}
