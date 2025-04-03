//
//  ExchangeTrackerUITests.swift
//  ExchangeTrackerUITests
//
//  Created by Kamran on 31.03.25.
//

import XCTest

final class ExchangeTrackerUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIDevice.shared.orientation = .portrait
        app.launchArguments = ["UI-TESTING"]
    }
 
    func testAddingAssetAppearsOnHome() {
        AppRobot(app: app)
            .launch()
            .home { home in
                _ = home.tapAddButton()
            }
            .addAsset { addAsset in
                _ = addAsset.selectAsset(id: "AED")
                    .assertAssetSelected("AED")
                    .tapDone()
            }
            .home { home in
                _ = home.assertAssetExists("AED")
            }
    }
}
