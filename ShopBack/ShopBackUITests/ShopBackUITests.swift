//
//  ShopBackUITests.swift
//  ShopBackUITests
//
//  Created by Win on 10/5/19.
//  Copyright © 2019 Win. All rights reserved.
//

import XCTest
@testable import ShopBack

class ShopBackUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
         app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 15) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
    
    func testElementExists() {
       
        let tableView = app.tables.element(boundBy: 0)
        XCTAssert(tableView.exists)
        
        self.waitForElementToAppear(tableView.cells.firstMatch)
        
        XCTAssert(tableView.cells.staticTexts["title"].exists)
        XCTAssert(tableView.cells.staticTexts["popularity"].exists)
        XCTAssert(tableView.cells.images["image"].exists)
        
        app.tables.element.swipeUp()
        
        if(tableView.cells.count > 0) {
            let firstCell = tableView.cells.element(boundBy: 0)
            firstCell.tap()
       
            sleep(5)
            XCTAssert(app.staticTexts["title"].exists)
            XCTAssert(app.staticTexts["synopsis"].exists)
            XCTAssert(app.staticTexts["genre"].exists)
            XCTAssert(app.staticTexts["language"].exists)
            XCTAssert(app.staticTexts["duration"].exists)
        }
        
        let button = app.buttons["BOOK"]
        button.tap()
        
        let webView = app.otherElements["webViewId"]
        self.waitForElementToAppear(webView)
        XCTAssert(app.navigationBars["BOOKING"].exists)
        XCTAssert(webView.exists)
        
    }
    

}
