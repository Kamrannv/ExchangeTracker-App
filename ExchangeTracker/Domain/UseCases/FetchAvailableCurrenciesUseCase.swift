//
//  FetchAvailableCurrenciesUseCase.swift
//  ExchangeTracker
//
//  Created by Kamran on 03.04.25.
//
import Foundation

protocol FetchAvailableCurrenciesUseCaseProtocol {
    func execute(currentlySelected: [Asset]) async throws -> [Asset]
}

final class FetchAvailableCurrenciesUseCase: FetchAvailableCurrenciesUseCaseProtocol {
    private let repository: ExchangeRepository
    private let factory: AssetFactoryProtocol
    private var cachedAssets: [Asset]?
    private var lastFetchTime: Date?
    
    init(repository: ExchangeRepository, factory: AssetFactoryProtocol) {
            self.repository = repository
            self.factory = factory
        }

    func execute(currentlySelected: [Asset]) async throws -> [Asset] {
           let now = Date()
           if let cachedAssets, let lastFetchTime, now.timeIntervalSince(lastFetchTime) < 60 {
               return cachedAssets
           }

           let rawSymbols = try await repository.getRawAllAssets()
           let mapped = factory.buildAssets(from: rawSymbols)
           let normalizedSelected = factory.normalize(selected: currentlySelected)

           let result = mergeSelectedAssets(mapped, with: normalizedSelected)
               .sorted { $0.name < $1.name }

           cachedAssets = result
           lastFetchTime = now
           return result
       }

       private func mergeSelectedAssets(_ fetched: [Asset], with selected: [Asset]) -> [Asset] {
           let existingIds = Set(fetched.map { $0.id })
           let newFromSelected = selected.filter { !existingIds.contains($0.id) }
           return fetched + newFromSelected
       }
}
