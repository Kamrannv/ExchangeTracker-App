//
//  BaseViewModel.swift
//  ExchangeTracker
//
//  Created by Kamran on 31.03.25.
//
import Foundation
import Combine
import SwiftUI
import SwiftData

@MainActor
open class BaseViewModel<S: UIState, I: UIIntent, R>: ObservableObject {
    @Published public var state: S

    public init(state: S) {
        self.state = state
    }
    public func send(_ event: I) {
        handleUIEvent(event)
    }

    open func handleUIEvent(_ event: I) {
        // method will be overriden in viewmodel in order to make actions on UI events
    }

    public func update(_ update: @escaping (inout S) -> Void) {
        update(&state)
    }
    //MARK: Added for SwiftData
    open func setContext(_ context: ModelContext) {
    }
    public func handleError(_ error: Error) {
        let message = error.localizedDescription
          ErrorToastManager.shared.show(message)
       }
}

