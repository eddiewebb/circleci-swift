//
//  todolyTests.swift
//  todolyTests
//
//  Created by Eugene Choe on 1/24/18.
//  Copyright © 2018 heug. All rights reserved.
//

import XCTest
@testable import todoly

class todolyTests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // add items to list successfully
    func testAdd()
    {
        var toDoItemList = ToDoItem.initializeList()
        
        toDoItemList.append(ToDoItem(title: "Chocolate"))
        XCTAssert(toDoItemList.count == 1)
        toDoItemList.append(ToDoItem(title: "Milk"))
        XCTAssert(toDoItemList.count == 2)
        toDoItemList.append(ToDoItem(title: "Dog food"))
        XCTAssert(toDoItemList.count == 3)
    }
    
}
