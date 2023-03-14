//
//  BackServicesTests.swift
//  BackServicesTests
//
//  Created by jose perez on 01/03/22.
//

import XCTest
@testable import BackServices

class BackServicesTests: XCTestCase, BSResponseDelegate {
    func recievedEntity<T>(entity: T, requestName: String) {
        switch requestName {
        case String(describing: BSFighterHistory.self):
            print("Next \(entity)")
        default: break
        }
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCodableFighter() throws {        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
