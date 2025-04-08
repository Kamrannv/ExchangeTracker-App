//
//  AssetFactory.swift
//  ExchangeTracker
//
//  Created by Kamran on 08.04.25.
//
protocol AssetFactoryProtocol {
    func buildAssets(from symbols: [String]) -> [Asset]
    func normalize(selected: [Asset]) -> [Asset]
}

final class AssetFactory: AssetFactoryProtocol {
    // MARK: - Most of the public APIs return many unnecessary crypto assets.
    // To address this, i use a single API that returns both cryptos and fiats as a dictionary.
    // I then group them based on symbol IDs to separate cryptos from fiats.
    
    private let symbolToId: [String: String] = [
        "btc": "bitcoin", "eth": "ethereum", "ltc": "litecoin", "bch": "bitcoin-cash",
        "bnb": "binancecoin", "eos": "eos", "xrp": "ripple", "xlm": "stellar",
        "link": "chainlink", "dot": "polkadot", "yfi": "yearn-finance", "sats": "satoshis",
        "bits": "bitstar", "doge": "dogecoin", "avax": "avalanche-2", "matic": "matic-network",
        "sol": "solana", "etc": "ethereum-classic", "ada": "cardano", "uni": "uniswap",
        "shib": "shiba-inu", "usdt": "tether", "usdc": "usd-coin", "dai": "dai",
        "trx": "tron", "near": "near", "apt": "aptos", "fil": "filecoin"
    ]

    func buildAssets(from symbols: [String]) -> [Asset] {
        symbols.map { symbol in
            let id = symbol.lowercased()
            let coingeckoId = symbolToId[id] ?? id
            let type: AssetType = symbolToId.keys.contains(id) ? .crypto : .fiat
            return Asset(id: coingeckoId, name: id.uppercased(), type: type)
        }
    }

    func normalize(selected: [Asset]) -> [Asset] {
        selected.map { asset in
            let lowercased = asset.id.lowercased()
            let mappedId = symbolToId[lowercased] ?? lowercased
            return Asset(id: mappedId, name: asset.name, type: asset.type)
        }
    }
}
