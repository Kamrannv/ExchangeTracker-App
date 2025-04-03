//
//  ExchangeTrackerApp.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//

import SwiftUI
import SwiftData

@main
struct ExchangeTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
           let schema = Schema([CachedAsset.self])
           let modelConfiguration = ModelConfiguration(schema: schema)
           
           do {
               return try ModelContainer(for: schema, configurations: [modelConfiguration])
           } catch {
               return try! ModelContainer(for: schema, configurations: [
                              ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                          ])
           }
       }()
       

    var body: some Scene {
        WindowGroup {
            AppRootView()
        }
        .modelContainer(sharedModelContainer)
    }
}
