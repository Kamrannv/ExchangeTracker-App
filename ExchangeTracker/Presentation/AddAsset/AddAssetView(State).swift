//
//  AddAssetView(State).swift
//  ExchangeTracker
//
//  Created by Kamran on 01.04.25.
//

class AddAssetState: UIState {
    var allAssets: [Asset] = []
    var selectedAssets: [Asset] = []
    var searchText: String = ""

    var filteredPopularAssets: [Asset] {
        allAssets.filter { $0.type == .fiat && matchesSearch($0) }
    }

    var filteredCryptoAssets: [Asset] {
        allAssets.filter { $0.type == .crypto && matchesSearch($0) }
    }

    private func matchesSearch(_ asset: Asset) -> Bool {
        searchText.isEmpty || asset.name.localizedCaseInsensitiveContains(searchText)
    }
}
