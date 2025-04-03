//
//  HomeView(Builder).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

final class HomeViewBuilder {
    @MainActor static func build() -> Container<HomeState, HomeEvent, Never> {
        let vm = HomeViewModel(useCase: AppDIContainer.shared.fetchExchangeRatesUseCase)
        return Container(viewModel: vm)
    }
}
