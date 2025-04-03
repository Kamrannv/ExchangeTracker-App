//
//  ExchangeRate.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import SwiftUI
import Foundation

struct ExchangeRate: Codable, Equatable {
    let id: String
    let value: Double
    let percentageChange: Double
}

extension ExchangeRate {
    var changeText: String {
        let prefix = percentageChange >= 0 ? "+" : ""
        return "\(prefix)\(percentageChange.formatted(.number.precision(.fractionLength(2))))%"
    }

    var changeColor: Color {
        percentageChange >= 0 ? .green : .red
    }
}
