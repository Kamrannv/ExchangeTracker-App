//
//  AddAssetView(ViewModel).swift
//  ExchangeTracker
//
//  Created by Kamran on 01.04.25.
//
import Foundation

final class AddAssetViewModel: BaseViewModel<AddAssetState, AddAssetEvent, Never> {
    private let fetchAvailableCurrenciesUseCase: FetchAvailableCurrenciesUseCaseProtocol
    private let onConfirm: ([Asset]) -> Void
    
    init(
        fetchAvailableCurrenciesUseCase: FetchAvailableCurrenciesUseCaseProtocol,
        initiallySelected: [Asset],
        onConfirm: @escaping ([Asset]) -> Void
    ) {
        self.fetchAvailableCurrenciesUseCase = fetchAvailableCurrenciesUseCase
        self.onConfirm = onConfirm
        super.init(state: AddAssetState())
        update { $0.selectedAssets = initiallySelected }
    }
    
    override func handleUIEvent(_ event: AddAssetEvent) {
        switch event {
        case .viewDidAppear:
            Task { await loadCurrencies() }
        case .toggleSelection(let asset):
            if state.selectedAssets.contains(asset) {
                update { $0.selectedAssets.removeAll { $0 == asset } }
            } else {
                update { $0.selectedAssets.append(asset) }
            }
        case .confirmSelection:
            onConfirm(state.selectedAssets)
        }
    }
    
    private func loadCurrencies() async {
        do {
            let currencies = try await fetchAvailableCurrenciesUseCase.execute()
            update { $0.allAssets = currencies }
        } catch {
            handleError(error)
        }
    }
}
