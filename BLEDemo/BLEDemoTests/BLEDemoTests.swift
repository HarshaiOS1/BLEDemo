//
//  BLEDemoTests.swift
//  BLEDemoTests
//
//  Created by Krishnappa, Harsha on 24/05/2024.
//

import XCTest
import ComposableArchitecture

@testable import BLEDemo

final class BLEDemoTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStateChange() async {
        let bleListReducer = BLEListReducer()
        var currentState = BLEListReducer.State()
        _ = bleListReducer.reduce(into: &currentState, action: .scanForBLEDevices)
        XCTAssertTrue(currentState.isScanning)
        
        let dummyData = [BLEDevice(id: UUID(), name: "dummy device", RSSI: -85)]
        _ = bleListReducer.reduce(into: &currentState, action: .devicesFetched(dummyData))
        XCTAssertTrue((currentState.bleDevices?.count ?? 0) > 0)
        XCTAssertFalse(currentState.isScanning)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
