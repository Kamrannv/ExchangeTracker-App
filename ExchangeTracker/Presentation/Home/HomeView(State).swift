//
//  HomeView(State).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
class HomeState: UIState {
    var assets: [Asset] = []
    var rates: [String: ExchangeRate] = [:]
    var isLoading: Bool = false
    var error: String?
}
