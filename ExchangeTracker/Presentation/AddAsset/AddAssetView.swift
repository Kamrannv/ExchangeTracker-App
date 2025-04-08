//
//  AddAssetView.swift
//  ExchangeTracker
//
//  Created by Kamran on 01.04.25.
//

import SwiftUI

struct AddAssetView: View {
    @StateObject private var container: Container<AddAssetState, AddAssetEvent, Never>
    @Environment(\.dismiss) private var dismiss
    
    init(selectedAssets: [Asset], onConfirm: @escaping ([Asset]) -> Void) {
        _container = StateObject(wrappedValue: AddAssetViewBuilder.build(selectedAssets: selectedAssets, onConfirm: onConfirm))
    }
    
    var body: some View {
        NavigationStack {
            List {
                popularSection
                cryptoSection
            }
            .searchable(text: container.binding(\.searchText), prompt: "Search assets")
            .navigationTitle("Add Asset")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        container.send(.confirmSelection)
                        dismiss()
                    }
                }
            }
            .onAppear {
                container.send(.viewDidAppear)
                
            }
        }
    }
    // MARK: - View Sections
    private var popularSection: some View {
        Section(header: Text("POPULAR ASSETS")) {
            ForEach(container.state.filteredPopularAssets) { asset in
                assetRow(for: asset)
            }
        }
    }
    
    private var cryptoSection: some View {
        Section(header: Text("CRYPTOCURRENCIES")) {
            ForEach(container.state.filteredCryptoAssets) { asset in
                assetRow(for: asset)
            }
        }
    }
    
    private func assetRow(for asset: Asset) -> some View {
        let isSelected = container.state.selectedAssets.contains(asset)
        
        return HStack {
            VStack(alignment: .leading) {
                Text(asset.name)
                    .accessibilityIdentifier("AssetName_\(asset.name)")
                Text(asset.id)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .blue : .gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            container.send(.toggleSelection(asset))
        }
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("AssetCell_\(asset.id)")
    }
}

