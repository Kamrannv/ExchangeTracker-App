//
//  AppRootView.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//

import SwiftUI
import Foundation

struct AppRootView: View {
    @StateObject private var toastManager = ErrorToastManager.shared

    var body: some View {
        ZStack {
            HomeView()

            if let message = toastManager.message {
                ErrorPopupView(message: message)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: toastManager.message)
    }
}
