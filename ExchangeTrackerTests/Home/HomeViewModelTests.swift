//
//  HomeViewModelTests.swift
//  ExchangeTrackerTests
//
//  Created by Kamran on 04.04.25.
//

import Testing
import Foundation
@testable import ExchangeTracker


final class HomeViewModelTests {
    private var sut: HomeViewModel!
    private var mockUseCase: FetchExchangeRatesUseCaseMock!
    
    @MainActor
    init() throws {
        mockUseCase = FetchExchangeRatesUseCaseMock()
        sut = .init(useCase: mockUseCase)
    }
    
    // MARK: - Tests
    
    @Test
    func testViewDidAppear_loadsAndFetchesRates() async throws  {
        await sut.handleUIEvent(.viewDidAppear)
        let asset = Asset(id: "USD", name: "US Dollar", type: .fiat)
        mockUseCase.result = [
            ExchangeRate(id: "USD", value: 1.0, percentageChange: 0.05)
        ]
        
        await sut.update { $0.assets = [asset] }
        
        
        await #expect(sut.state.rates["USD"]?.value == 1.0)
        await #expect(sut.state.error == nil)
    }
    @Test
    func testAddAsset_appendsNewAssetAndFetches() async throws {
        let asset = Asset(id: "EUR", name: "Euro", type: .fiat)
        mockUseCase.result = [ExchangeRate(id: "EUR", value: 1.1, percentageChange: 0.1)]
        
        await sut.handleUIEvent(.addAsset(asset))
        
        await #expect(sut.state.assets.contains(asset))
        await #expect(sut.state.rates["EUR"]?.value == 1.1)
    }
    
    @Test
    func testAddAsset_doesNotAppendIfAlreadyExists() async throws {
        let asset = Asset(id: "JPY", name: "Yen", type: .fiat)
        await sut.update { $0.assets = [asset] }
        
        await sut.handleUIEvent(.addAsset(asset))
        
        await #expect(sut.state.assets.count == 1)
    }
    
    @Test
    func testRemoveAsset_removesAtIndex() async throws {
        let asset1 = Asset(id: "USD", name: "US Dollar", type: .fiat)
        let asset2 = Asset(id: "EUR", name: "Euro", type: .fiat)
        await sut.update { $0.assets = [asset1, asset2] }
        
        await sut.handleUIEvent(.removeAsset(IndexSet(integer: 0)))
        
        await #expect(sut.state.assets == [asset2])
    }
    
    @Test
    func testReplaceAssets_setsAssetsAndFetches() async throws {
        let asset = Asset(id: "BTC", name: "Bitcoin", type: .crypto)
        mockUseCase.result = [ExchangeRate(id: "BTC", value: 50_000, percentageChange: 1.5)]
        
        await sut.handleUIEvent(.replaceAssets([asset]))
        
        await #expect(sut.state.assets == [asset])
        await #expect(sut.state.rates["BTC"]?.value == 50_000)
    }
    
}





