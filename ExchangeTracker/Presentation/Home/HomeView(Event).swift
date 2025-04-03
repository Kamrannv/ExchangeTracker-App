//
//  HomeView(Event).swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import Foundation

enum HomeEvent: UIIntent {
    case viewDidAppear
    case addAsset(Asset)
    case removeAsset(IndexSet)
    case refresh
    case replaceAssets([Asset])
}
