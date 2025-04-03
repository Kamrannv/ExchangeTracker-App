//
//  HomeView(ViewModel).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation
import SwiftData

@MainActor
final class HomeViewModel: BaseViewModel<HomeState, HomeEvent, Never> {
    private let useCase: FetchExchangeRatesUseCaseProtocol
    private var timer: Timer?
    private var modelContext: ModelContext?
    
    
    init(useCase: FetchExchangeRatesUseCaseProtocol, state: HomeState = HomeState()) {
        self.useCase = useCase
        super.init(state: state)
    }
    
    override func setContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    override func handleUIEvent(_ event: HomeEvent) {
        switch event {
        case .viewDidAppear:
            loadAssets()
            startAutoRefresh()
            Task { await fetchRates(showLoading: false) }
            
        case .addAsset(let asset):
            guard !state.assets.contains(asset) else { return }
            update { $0.assets.append(asset) }
            saveAssets()
            Task { await fetchRates(showLoading: true) }
            
        case .removeAsset(let indexes):
            update { $0.assets.remove(atOffsets: indexes) }
            saveAssets()
            
        case .refresh:
            Task { await fetchRates(showLoading: false) }
            
        case .replaceAssets(let updatedAssets):
            update { $0.assets = updatedAssets }
            saveAssets()
            Task { await fetchRates(showLoading: true) }
        }
    }
    
    
    private func startAutoRefresh() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            Task { await self?.fetchRates(showLoading: false)}
        }
    }
    
    private func fetchRates(showLoading: Bool) async {
        if showLoading {
            update { $0.isLoading = true }
        }
        do {
            let result = try await useCase.execute(for: state.assets)
            update {
                $0.rates = Dictionary(uniqueKeysWithValues: result.map { ($0.id, $0) })
                $0.error = nil
                if showLoading { $0.isLoading = false }
            }
            
        } catch {
            update {
                $0.error = error.localizedDescription
                if showLoading { $0.isLoading = false }
            }
        }
    }
    private func saveAssets() {
        guard let modelContext else { return }
        
        do {
            let descriptor = FetchDescriptor<CachedAsset>()
            let existing = try modelContext.fetch(descriptor)
            existing.forEach { modelContext.delete($0) }
            
            for asset in state.assets {
                modelContext.insert(asset.toCache())
            }
            try modelContext.save()
        } catch {
            handleError(error)
        }
    }
    
    private func loadAssets() {
        guard let modelContext else { return }
        do {
            let cached = try modelContext.fetch(FetchDescriptor<CachedAsset>())
            let assets = cached.map { $0.toDomain }
            update { $0.assets = assets }
        } catch {
            handleError(error)
        }
    }
}
extension Container where S == HomeState, I == HomeEvent, R == Never {
    func setSwiftDataContext(_ context: ModelContext) {
        (viewModel as? HomeViewModel)?.setContext(context)
    }
}
