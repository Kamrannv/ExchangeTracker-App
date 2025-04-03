//
//  ExchangeRateEndpoint.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

public enum ExchangeEndPoints: EndPointType {
    case currencyRate([Asset])
    case currencies
    

    var baseURL: String {
        "https://openexchangerates.org/api"
    }

    var path: String {
        switch self {
        case .currencyRate:
            return "/latest.json"
        case .currencies:
            return "/currencies.json"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .currencyRate, .currencies:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .currencyRate(let assets):
                   return [
                       "app_id": "7f92d395e47c4ee7939326121e283211",
                       "base": "USD",
                       "symbols": assets.map { $0.id }.joined(separator: ",")
                   ]
               case .currencies:
                   return [
                       "app_id": "7f92d395e47c4ee7939326121e283211"
                   ]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
            default:
            return .url
        }
    }

    var headers: HTTPHeaders {
        ["Accept": "application/json"]
    }
}
