//
//  EndpointType.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders { get }
}

extension EndPointType {
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        if encoding == .url, let params = parameters {
            components?.queryItems = params.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        return components?.url
    }

    func buildRequest() throws -> URLRequest {
        guard let url = self.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        if encoding == .json, let params = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        return request
    }
}
