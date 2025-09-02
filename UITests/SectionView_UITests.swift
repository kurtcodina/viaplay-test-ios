//
//  SectionView_UITests.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import XCTest

final class SectionView_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_SectionView_loader_shouldShowWhenLoading() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.sectionLoader.rawValue)
        app.launch()
        
        app.buttons["Serier"].tap()
        
        XCTAssertTrue(app.activityIndicators.firstMatch.exists)
    }
    
    func test_SectionView_noContent_shouldShowEmptyState() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.sectionNoContent.rawValue)
        app.launch()
        
        app.buttons["Serier"].tap()

        XCTAssertTrue(app.staticTexts["Content Unavailable"].exists)
    }
    
    func test_SectionView_navigationToRootView_shouldNavigateCorrectly() {
        let app = XCUIApplication()
        app.launchArguments.append(UITestLaunchArguments.rootSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.sectionSuccess.rawValue)
        app.launchArguments.append(UITestLaunchArguments.listNavigationToSection.rawValue)
        app.launch()

        app.buttons["Serier"].tap()
        app.buttons["Home"].tap()

        XCTAssertTrue(app.staticTexts["Home"].exists)
    }
    
}
