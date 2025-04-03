//
//  Asset.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

public enum AssetType: String, Codable {
    case fiat
    case crypto
}

public struct Asset: Identifiable, Codable, Hashable {
    public let id: String // UUID or String?
    let name: String
    let type: AssetType
}
