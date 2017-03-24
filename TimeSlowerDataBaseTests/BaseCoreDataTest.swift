//
//  TimeSlowerDataBaseTests.swift
//  TimeSlowerDataBaseTests
//
//  Created by Alex Shcherbakov on 3/22/17.
//  Copyright © 2017 Alex Shcherbakov. All rights reserved.
//

import XCTest
import CoreData
@testable import TimeSlowerDataBase

class BaseCoreDataTest: XCTestCase {

    var dataStore: DataStore!

    override func setUp() {
        super.setUp()

        let storeExpectation = expectation(description: "Stores should be loaded")
        dataStore = DataStore(environment: .test)
        dataStore.load {
            storeExpectation.fulfill()
        }

        waitForExpectations(timeout: 1) { (error) in }
    }
    
    override func tearDown() {
        dataStore = nil
        super.tearDown()
    }
    
    func test_storeSettings_inMemory() {
//        let storeExpectation = expectation(description: "Stores should be loaded")
//
//        dataStore.load { [weak self] in
//            let container = self?.dataStore.persistentContainer
//            XCTAssertNotNil(container)
//            XCTAssertEqual(container?.persistentStoreDescriptions.count, 1)
//            XCTAssertEqual(container?.persistentStoreDescriptions.first?.type, NSInMemoryStoreType)
//            storeExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1) { (error) in
//            if let error = error {
//                XCTFail("Failed with error: \(error)")
//            }
//        }
    }

    func test_InMemoryStoreSetup() {
        let container = dataStore.persistentContainer
        XCTAssertNotNil(container)
        XCTAssertEqual(container?.persistentStoreDescriptions.count, 1)
        XCTAssertEqual(container?.persistentStoreDescriptions.first?.type, NSInMemoryStoreType)
    }

}
