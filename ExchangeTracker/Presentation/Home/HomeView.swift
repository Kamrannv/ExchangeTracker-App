//
//  HomeView.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var container = HomeViewBuilder.build()
    @Environment(\.modelContext) private var modelContext
    @State private var showAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                if container.state.assets.isEmpty {
                    emptyStateView
                }
                
                ForEach(container.state.assets) { asset in
                    if let rate = container.state.rates[asset.id] {
                        rateRow(asset: asset, rate: rate)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        container.send(.removeAsset(indexSet))
                    }
                }
            }
            .overlay {
                if container.state.isLoading {
                    loadingView
                } else if let error = container.state.error {
                    errorView(error)
                }
            }
            .navigationTitle("Exchange Rates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                           
                    }
                    .accessibilityIdentifier("AddAssetButton")
                }
            }
            .onAppear {
                container.setSwiftDataContext(modelContext)
                container.send(.viewDidAppear)
            }
            .sheet(isPresented: $showAddSheet) {
                AddAssetView(
                    selectedAssets: container.state.assets,
                    onConfirm: { updatedAssets in
                        container.send(.replaceAssets(updatedAssets))
                    }
                )
            }
        }
    }
    
    //MARK: - Subviews
    private var emptyStateView: some View {
        Text("No assets selected. Tap '+' to add.")
            .foregroundColor(.gray)
            .italic()
    }
    
    private func rateRow(asset: Asset, rate: ExchangeRate) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(asset.id)
                    .font(.headline)
                Text(asset.name)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .accessibilityIdentifier("AssetName_\(asset.id)")
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(rate.value.formatted())
                    .contentTransition(.numericText())
                    .font(.headline)
                
                Text(rate.changeText)
                    .font(.caption)
                    .foregroundColor(rate.changeColor)
                    .contentTransition(.numericText())
            }
            .animation(.default, value: rate.value)
        }
        .padding(.vertical, 4)
        .transition(.opacity)
        .animation(.easeInOut, value: rate)
    }
    
    private var loadingView: some View {
        ProgressView("Updating...")
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    private func errorView(_ error: String) -> some View {
        VStack {
            Text("⚠️ \(error)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

