//
//  AddAssetView(Event).swift
//  ExchangeTracker
//
//  Created by Kamran on 01.04.25.
//

enum AddAssetEvent: UIIntent {
    case viewDidAppear
    case toggleSelection(Asset)
    case confirmSelection
}
