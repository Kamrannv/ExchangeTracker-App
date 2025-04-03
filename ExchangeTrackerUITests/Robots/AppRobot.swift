//
//  AppRobot.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//
import XCTest

struct AppRobot {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func launch() -> Self {
        app.launch()
        return self
    }
    
    @discardableResult
    func home(_ closure: (HomeRobot) -> Void) -> Self {
        closure(HomeRobot(app: app))
        return self
    }
    
    @discardableResult
    func addAsset(_ closure: (AddAssetRobot) -> Void) -> Self {
        closure(AddAssetRobot(app: app))
        return self
    }
}
