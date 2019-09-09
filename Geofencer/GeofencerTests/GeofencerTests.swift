//
//  GeofencerTests.swift
//  GeofencerTests
//
//  Created by Brett Parsekian on 7/30/19.
//  Copyright © 2019 bparsekian. All rights reserved.
//

import XCTest
@testable import Geofencer

class GeofencerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJsonDecoder() {
        let actuals: [(Double, Double, String)] =
        [(34.1413891, -118.1507140, "Select Physical Therapy"),
        (34.1471415, -118.2464751, "Dollar Tree"),
        (34.1537760, -118.2428634, "Virgil's Hardware Home Center"),
        (34.115110, -118.248561, "Goodwill"),
        (34.1364105, -118.2589307, "Salvation Army Corps & Community Center"),
        (34.1486856, -118.2346624, "Smart & Final Extra!"),
        (34.1429980, -118.2586030, "Target"),
        (48.8861929, 2.3430895, "Montmartre"),
        (48.8462217, 2.3371605, "Luxembourg Gardens"),
        (48.8583424, 2.3375084, "Pont des Arts"),
        (34.0773927, -118.2208076, "Society of St. Vincent de Paul Los Angeles Thrift Store"),
        (34.0946477, -118.1284956, "In Motion Sports"),
        (34.1492278, -118.0739699, "Harbor Freight Tools")]
        
        let places = PlacesDecoder.fetchPlaces()
        let geoPointAccuracy = 0.0000001
        
        for (i, actualPlace) in actuals.enumerated() {
            let acutalLat = actualPlace.0
            let actualLong = actualPlace.1
            let actualTitle = actualPlace.2
            XCTAssertEqual(places[i].coordinates.latitude, acutalLat, accuracy: geoPointAccuracy)
            XCTAssertEqual(places[i].coordinates.longitude, actualLong, accuracy: geoPointAccuracy)
            XCTAssertEqual(places[i].title, actualTitle)
        }
    }

}
