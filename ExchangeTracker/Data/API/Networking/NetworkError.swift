//
//  NetworkError.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case serverError(Int)
    case decodingFailed
    case unexpectedResponse
    case noConnection
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let message):
            return "Server Error: \(message)"
        case .decodingFailed:
            return "Decoding Failed"
        case .unexpectedResponse:
            return "Unexpected Response"
        case .noConnection:
            return "No Connection"
        default:
            return "Unknown Error"
        }
    }
}
