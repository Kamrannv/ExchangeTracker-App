//
//  AddAssetRobot.swift
//  ExchangeTracker
//
//  Created by Kamran on 04.04.25.
//

import XCTest
import Foundation

struct AddAssetRobot {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var doneButton: XCUIElement {
        app.navigationBars.buttons["Done"]
    }
  
    func selectAsset(id: String) -> Self {
       
        let assetTexts = app.staticTexts.matching(identifier: "AssetName_\(id)")
        
        if assetTexts.count > 0 {
            let predicate = NSPredicate(format: "identifier CONTAINS %@", "AssetCell_\(id)")
            let cell = app.cells.element(matching: predicate)
            
            if cell.waitForExistence(timeout: 5) {
                cell.tap()
                return self
            }
            
            let firstText = assetTexts.firstMatch
            if firstText.waitForExistence(timeout: 5) {
                firstText.tap()
                return self
            }
        }
    
        let cellPredicate = NSPredicate(format: "label CONTAINS %@", id)
        let anyCell = app.cells.element(matching: cellPredicate)
        
        if anyCell.waitForExistence(timeout: 5) {
            anyCell.tap()
            return self
        }
        
        XCTFail("Could not find any way to select asset \(id)")
        return self
    }

    func assertAssetSelected(_ id: String) -> Self {
        let checkmarks = app.images.matching(NSPredicate(format: "identifier CONTAINS %@", "checkmark.circle.fill"))
        
        XCTAssertTrue(checkmarks.count > 0, "No checkmark found")
        return self
    }
   
    func tapDone() -> Self {
        doneButton.tap()
        return self
    }
}
