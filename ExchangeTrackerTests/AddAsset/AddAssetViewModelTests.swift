//
//  AddAssetViewModelTests.swift
//  ExchangeTrackerTests
//
//  Created by Kamran on 04.04.25.
//

import Testing
@testable import ExchangeTracker


final class AddAssetViewModelTests {
    private var sut: AddAssetViewModel!
    private var mockUseCase: FetchAvailableCurrenciesUseCaseMock!
    private var confirmedAssets: [Asset] = []
    
    @MainActor
    init() throws {
        mockUseCase = FetchAvailableCurrenciesUseCaseMock()
        sut = .init(
            fetchAvailableCurrenciesUseCase: mockUseCase,
            initiallySelected: [],
            onConfirm: { [weak self] assets in
                self?.confirmedAssets = assets
            }
        )
    }
    
    // MARK: - Tests
    
    @Test
    func testViewDidAppear_loadsCurrencies() async throws {
        let asset = Asset(id: "USD", name: "US Dollar", type: .fiat)
        mockUseCase.result = [asset]
        
        await sut.handleUIEvent(.viewDidAppear)
        
        try await Task.sleep(nanoseconds: 100000)
        await #expect(sut.state.allAssets == [asset])
    }
    
    @Test
    func testToggleSelection_addsAssetIfNotSelected() async throws {
        let asset = Asset(id: "EUR", name: "Euro", type: .fiat)
        
        await sut.handleUIEvent(.toggleSelection(asset))
        
        await #expect(sut.state.selectedAssets.contains(asset))
    }
    
    @Test
    func testToggleSelection_removesAssetIfAlreadySelected() async throws {
        let asset = Asset(id: "EUR", name: "Euro", type: .fiat)
        await sut.update { $0.selectedAssets = [asset] }
        
        await sut.handleUIEvent(.toggleSelection(asset))
        
        await #expect(!sut.state.selectedAssets.contains(asset))
    }
    
    @Test
    func testConfirmSelection_callsCallbackWithSelectedAssets() async throws {
        let asset = Asset(id: "JPY", name: "Yen", type: .fiat)
        await sut.update { $0.selectedAssets = [asset] }
        
        await sut.handleUIEvent(.confirmSelection)
        
        #expect(confirmedAssets == [asset])
    }
    
}
