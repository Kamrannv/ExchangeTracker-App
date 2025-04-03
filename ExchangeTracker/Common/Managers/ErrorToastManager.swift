//
//  ErrorToastManager.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//

import SwiftUI
import Combine

@MainActor
final class ErrorToastManager: ObservableObject {
    static let shared = ErrorToastManager()

    @Published var message: String?

    func show(_ message: String) {
        self.message = message

        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            await MainActor.run {
                       self.message = nil
                   }
        }
    }
}
