//
//  ExchangeRate(ns).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

protocol ExchangeNetworkServiceDelegate {
    func fetchRawCryptoRates(ids: [String], vsCurrencies: [String]) async throws -> [String: [String: Double]]
    func fetchRawFiatRates(base: String, vsCurrencies: [String]) async throws -> [String: [String: Double]]
    func fetchRawAllAssets() async throws -> [String]
}

public class ExchangeNetworkService: ExchangeNetworkServiceDelegate {
    private let client: NetworkClient
    
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchRawCryptoRates(ids: [String], vsCurrencies: [String]) async throws -> [String: [String: Double]] {
        let endpoint = ExchangeEndPoints.cryptoRates(ids: ids, vsCurrencies: vsCurrencies)
        return try await client.request(endpoint, [String: [String: Double]].self)
    }
    
    func fetchRawFiatRates(base: String, vsCurrencies: [String]) async throws -> [String: [String: Double]] {
        let endpoint = ExchangeEndPoints.fiatRates(base: base, vsCurrencies: vsCurrencies)
        return try await client.request(endpoint, [String: [String: Double]].self)
    }
    
    func fetchRawAllAssets() async throws -> [String] {
        let endpoint = ExchangeEndPoints.allAssets
        return try await client.request(endpoint, [String].self)
    }
}
