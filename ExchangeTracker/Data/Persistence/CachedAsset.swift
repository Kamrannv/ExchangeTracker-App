//
//  StoredRate.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation
import SwiftData

@Model
final class CachedAsset {
    @Attribute(.unique) var id: String
    var name: String
    var typeRaw: String
    
    init(id: String, name: String, type: AssetType) {
        self.id = id
        self.name = name
        self.typeRaw = type.rawValue
    }
    var type: AssetType {
        AssetType(rawValue: typeRaw) ?? .fiat
    }
    var toDomain: Asset {
        Asset(id: id, name: name, type: type)
    }
}
extension Asset {
    func toCache() -> CachedAsset {
        CachedAsset(id: id, name: name, type: type)
    }
}
