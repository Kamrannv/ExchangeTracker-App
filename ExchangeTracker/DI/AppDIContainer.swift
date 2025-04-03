//
//  AppDIContainer.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

final class AppDIContainer {
    static let shared = AppDIContainer()

    private init() {}

    // MARK: Network client
    lazy var networkClient: NetworkClient = URLSessionNetworkClient()

    // MARK: - Services
    lazy var exchangeRateNetworkService: ExchangeNetworkServiceDelegate = {
        ExchangeNetworkService(client: networkClient)
    }()

    // MARK: - Repository
    lazy var exchangeRepository: ExchangeRepository = {
        ExchangeRepositoryImpl(networkService: exchangeRateNetworkService)
    }()

    // MARK: - UseCases
    lazy var fetchExchangeRatesUseCase: FetchExchangeRatesUseCase = {
        FetchExchangeRatesUseCase(repository: exchangeRepository)
    }()
    
    lazy var fetchAvailableCurrenciesUseCase: FetchAvailableCurrenciesUseCase = {
        FetchAvailableCurrenciesUseCase(repository: exchangeRepository)
       }()
}
