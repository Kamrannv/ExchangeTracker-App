//
//  HomeRobot.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//
import XCTest

struct HomeRobot {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var addButton: XCUIElement {
        app.buttons["AddAssetButton"]
    }

    var assetCell: XCUIElementQuery {
        app.tables.cells
    }

    func tapAddButton() -> Self {
        let button = addButton
           XCTAssertTrue(button.waitForExistence(timeout: 3), "Add button did not appear")
           button.tap()
           return self
    }

    func assertAssetExists(_ assetId: String) -> Self {
        let nameText = app.staticTexts["AssetName_\(assetId)"]
        
        if nameText.waitForExistence(timeout: 5) {
            return self
        }

        let predicate = NSPredicate(format: "label CONTAINS %@", assetId)
        let anyMatch = app.staticTexts.element(matching: predicate)
        
        XCTAssertTrue(anyMatch.exists, "No element containing \(assetId) found")
        return self
    }

    func assertEmptyStateExists() -> Self {
        XCTAssertTrue(app.staticTexts["No assets selected. Tap '+' to add."].exists)
        return self
    }
}
