//
//  AddAssetView(Builder).swift
//  ExchangeTracker
//
//  Created by Kamran on 01.04.25.
//


import Foundation

final class AddAssetViewBuilder {
    @MainActor static func build( selectedAssets: [Asset],
                                  onConfirm: @escaping ([Asset]) -> Void) -> Container<AddAssetState, AddAssetEvent, Never> {

        let vm = AddAssetViewModel(
            fetchAvailableCurrenciesUseCase: AppDIContainer.shared.fetchAvailableCurrenciesUseCase,
            initiallySelected: selectedAssets,
            onConfirm: onConfirm
        )
        return Container(viewModel: vm)
    }
}
