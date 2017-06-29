//
//  EarthQuakeAppForDexcomTests.swift
//  EarthQuakeAppForDexcomTests
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import XCTest
@testable import EarthQuakeAppForDexcom

class EarthQuakeAppForDexcomTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonDataIsDict() {
        let expectation = XCTestExpectation(description: "isJson")
        let api = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson")
        EarthquakeDownloadManager.downloadDataWithURL(url: api!) { (data) in
            XCTAssertTrue(data is [String:Any])
            print(data)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 4.0)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testJsonDataIsArray(){
        let expectation = XCTestExpectation(description: "isArray")
        EarthquakeDownloadManager.getFeaturesArrayFromDict(url: EarthquakeDownloadManager.api, arrayKey: "features") { (arr) in
            XCTAssertTrue(arr is [[String:Any]])
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 4.0)
    }
    func testDataIsFeature(){
        let expectation = XCTestExpectation(description: "isFeature")
        EarthquakeDownloadManager.getFeatureObjectsFromArray(url: EarthquakeDownloadManager.api, arrayKey: "features") { (arr) in
            XCTAssertTrue(arr is [EarthQuakeFeature])
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 4.0)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
