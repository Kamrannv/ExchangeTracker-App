//
//  ExchangeRateEndpoint.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

public enum ExchangeEndPoints: EndPointType {
    case cryptoRates(ids: [String], vsCurrencies: [String])
    case fiatRates(base: String, vsCurrencies: [String])
    case allAssets
    
    
    var baseURL: String {
        "https://api.coingecko.com/api/v3"
    }
    
    var path: String {
        switch self {
        case .cryptoRates, .fiatRates:
            return "/simple/price"
        case .allAssets:
            return "/simple/supported_vs_currencies"
        }
    }
    
    var httpMethod: HTTPMethod { .get }
    
    
    var parameters: Parameters? {
        switch self {
            
        case .cryptoRates(let ids, let vsCurrencies):
            return ["ids": ids.joined(separator: ","), "vs_currencies": vsCurrencies.joined(separator: ",")]
        case .fiatRates(let base, let vsCurrencies):
            return ["ids": base, "vs_currencies": vsCurrencies.joined(separator: ",")]
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return .url
        }
    }
    
    var headers: HTTPHeaders {
        [
            "Accept": "application/json",
            "x-cg-demo-api-key": "CG-i2tXxn9F4NQ98Uf6VwKfxi8x"
        ]
    }
}
