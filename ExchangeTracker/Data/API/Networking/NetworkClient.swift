//
//  NetworkClient.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: EndPointType, _ responseType: T.Type) async throws -> T
}

final class URLSessionNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: EndPointType, _ responseType: T.Type) async throws -> T {
        do {
            let request = try endpoint.buildRequest()
            logRequest(request, endpoint: endpoint)
            
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unexpectedResponse
            }
            logResponse(data: data, response: httpResponse)
            switch httpResponse.statusCode {
            case 200..<300:
                do {
                    return try decoder.decode(T.self, from: data)
                } catch let decodingError {
                    print("🔴 Decoding Error: \(decodingError)")
                    throw NetworkError.decodingFailed
                }
            case 400..<500:
                print("🟠 Client Error: \(httpResponse.statusCode)")
                throw NetworkError.serverError(httpResponse.statusCode)
                //MARK: did not handle 401 logic case as the test task will use only public APIs without any token
            default:
                print("🔴 Unexpected status code: \(httpResponse.statusCode)")
                throw NetworkError.unexpectedResponse
            }
        } catch {
            print("🔴 Network Error: \(error)")
            if let error = error as? NetworkError {
                throw error
            } else {
                throw NetworkError.unknown
            }
        }
    }
    
    private func logRequest(_ request: URLRequest, endpoint: EndPointType) {
          print("\n REQUEST")
          print("➡️ URL: \(request.url?.absoluteString ?? "No URL")")
          print("➡️ Method: \(request.httpMethod ?? "Unknown")")
          print("➡️ Headers: \(request.allHTTPHeaderFields ?? [:])")
          if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
              print("➡️ Body: \(bodyString)")
          }
      }
    
    private func logResponse(data: Data, response: HTTPURLResponse) {
           print("\n RESPONSE")
           print("⬅️ Status Code: \(response.statusCode)")
           if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
              let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
              let prettyString = String(data: prettyData, encoding: .utf8) {
               print("⬅️ Body: \n\(prettyString)")
           } else if let raw = String(data: data, encoding: .utf8) {
               print("⬅️ Body (raw): \n\(raw)")
           } else {
               print("⬅️ Body: (unable to decode)")
           }
       }
}
