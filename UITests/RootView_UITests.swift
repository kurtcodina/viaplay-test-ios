//
//  RootView_UITests.swift
//  Viaplay-TestUITests
//
//  Created by codina on 9/2/25.
//

import XCTest

final class RootView_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_RootView_loader_shouldShowWhenLoading() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootLoader.rawValue)
        app.launch()

        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
    }
    
    func test_RootView_contentUnavailable_shouldShowWhenNoContent() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootNoContent.rawValue)
        app.launch()

        XCTAssertTrue(app.staticTexts["Content Unavailable"].exists)
    }
    
    func test_RootView_navigationToSectionView_shouldNavigateCorrectly() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.sectionSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.listNavigationToRoot.rawValue)
        app.launch()
        
        app.buttons["Serier"].tap()
        
        XCTAssertTrue(app.staticTexts["Serier"].exists)
    }
    
}
