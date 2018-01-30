//
//  todolyUITests.swift
//  todolyUITests
//
//  Created by Eugene Choe on 1/24/18.
//  Copyright © 2018 heug. All rights reserved.
//

import XCTest

class todolyUITests: XCTestCase {
    
    let app = XCUIApplication()
    lazy var addItemButton = app.navigationBars["CircleCI todoly"].buttons["Add"]
    lazy var newToDoItemAlert = app.alerts["New to-do item"]
    lazy var textField = newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAdd() {
        addItemButton.tap()
        textField.typeText("Walk the dog")
        newToDoItemAlert.buttons["OK"].tap()
        XCTAssert(app.descendants(matching: .table).children(matching: .cell).count == 1)
        addItemButton.tap()
        textField.typeText("Wash hair")
        newToDoItemAlert.buttons["OK"].tap()
        XCTAssert(app.descendants(matching: .table).children(matching: .cell).count == 2)
    }
    
    func testRemove() {
        let newToDoItemAlert = app.alerts["New to-do item"]
        let textField = newToDoItemAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        
        addItemButton.tap()
        textField.typeText("Go for a run")
        newToDoItemAlert.buttons["OK"].tap()
        addItemButton.tap()
        textField.typeText("Go for a walk")
        newToDoItemAlert.buttons["OK"].tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.staticTexts["Go for a run"]/*[[".cells.staticTexts[\"Go for a run\"]",".staticTexts[\"Go for a run\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.swipeLeft()
        app.tables.buttons["Delete"].tap()
        XCTAssert(app.descendants(matching: .table).children(matching: .cell).count == 1)
    }
}
