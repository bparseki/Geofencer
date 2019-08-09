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
        guard let url = Bundle.main.url(forResource: "Saved Places", withExtension: "json") else { return }
        guard let json = try? Data(contentsOf: url) else { return }
        let decoder = JSONDecoder()
        let geoPointAccuracy = 0.0000001
        do {
            let savedPlaces = try decoder.decode(SavedPlaces.self, from: json)
            XCTAssertEqual(savedPlaces.places[0].coordinates.latitude, 34.1413891, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].coordinates.longitude, -118.1507140, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].title, "Select Physical Therapy")
            
            XCTAssertEqual(savedPlaces.places[1].coordinates.latitude, 34.1471415, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[1].coordinates.longitude, -118.2464751, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[1].title, "Dollar Tree")
            
            XCTAssertEqual(savedPlaces.places[2].coordinates.latitude, 34.1537760, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[2].coordinates.longitude, -118.2428634, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[2].title, "Virgil's Hardware Home Center")
            
            XCTAssertEqual(savedPlaces.places[3].coordinates.latitude, 34.115110, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[3].coordinates.longitude, -118.248561, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[3].title, "Goodwill")
            
            XCTAssertEqual(savedPlaces.places[4].coordinates.latitude, 34.1364105, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[4].coordinates.longitude, -118.2589307, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[4].title, "Salvation Army Corps & Community Center")
            
            XCTAssertEqual(savedPlaces.places[5].coordinates.latitude, 34.1486856, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[5].coordinates.longitude, -118.2346624, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[5].title, "Smart & Final Extra!")
            
            XCTAssertEqual(savedPlaces.places[6].coordinates.latitude, 34.1429980, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[6].coordinates.longitude, -118.2586030, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[6].title, "Target")
            
            XCTAssertEqual(savedPlaces.places[7].coordinates.latitude, 48.8861929, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[7].coordinates.longitude, 2.3430895, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[7].title, "Montmartre")
            
            XCTAssertEqual(savedPlaces.places[8].coordinates.latitude, 48.8462217, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[8].coordinates.longitude, 2.3371605, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[8].title, "Luxembourg Gardens")
            
            XCTAssertEqual(savedPlaces.places[9].coordinates.latitude, 48.8583424, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[9].coordinates.longitude, 2.3375084, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[9].title, "Pont des Arts")
            
            XCTAssertEqual(savedPlaces.places[10].coordinates.latitude, 34.0773927, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[10].coordinates.longitude, -118.2208076, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[10].title, "Society of St. Vincent de Paul Los Angeles Thrift Store")
            
            XCTAssertEqual(savedPlaces.places[11].coordinates.latitude, 34.0946477, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[11].coordinates.longitude, -118.1284956, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[11].title, "In Motion Sports")
            
            XCTAssertEqual(savedPlaces.places[12].coordinates.latitude, 34.1492278, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[12].coordinates.longitude, -118.0739699, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[12].title, "Harbor Freight Tools")
            
            
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
            XCTFail()
        }
        
        
        
    }

}
