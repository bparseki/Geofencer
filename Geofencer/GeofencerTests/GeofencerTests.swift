//
//  GeofencerTests.swift
//  GeofencerTests
//
//  Created by Brett Parsekian on 7/30/19.
//  Copyright © 2019 bparsekian. All rights reserved.
//

import XCTest
@testable import Geofencer

struct Place: Decodable {
    let title: String
    let coordinates: GeoCoordinates
}

struct GeoCoordinates {
    var latitude : Double
    var longitude: Double
}

extension GeoCoordinates : Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitudeString = try container.decode(String.self, forKey: .latitude)
        let longitudeString = try container.decode(String.self, forKey: .longitude)
        latitude = Double(latitudeString) ?? 0
        longitude = Double(longitudeString) ?? 0
    }
}

struct Location : Decodable {
    let geoCoordinates : GeoCoordinates
    
    enum CodingKeys: String, CodingKey {
        case geoCoordinates = "Geo Coordinates"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let gCoordinates = try container.decodeIfPresent(GeoCoordinates.self, forKey: .geoCoordinates)
        if (gCoordinates == nil) {
            let latitudeString = try container.decode(String.self, forKey: .latitude)
            let longitudeString = try container.decode(String.self, forKey: .longitude)
            geoCoordinates = GeoCoordinates(latitude : Double(latitudeString) ?? 0,
                                            longitude: Double(longitudeString) ?? 0)
        }
        else {
            geoCoordinates = gCoordinates!
        }
    }
}

struct Properties : Decodable {
    let location: Location
    let title : String
    
    enum CodingKeys: String, CodingKey {
        case location = "Location"
        case title = "Title"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try container.decode(Location.self, forKey: .location)
        title = try container.decode(String.self, forKey: .title)
    }
}

struct Feature : Decodable {
    let properties : Properties
    
    enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        properties = try container.decode(Properties.self, forKey: .properties)
    }
}

struct SavedPlaces {
    var features: [Feature]
    var places: [Place]
}

extension SavedPlaces: Decodable {
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case features = "features"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        features = try container.decode([Feature].self, forKey: .features)
        places = []
        for feature in features {
            //print(feature)
            let newPlace = Place(title: feature.properties.title,
                                 coordinates: feature.properties.location.geoCoordinates)
            places.append(newPlace)
        }
    }
}



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
        let geoPointAccuracy = 0.00001
        do {
            let savedPlaces = try decoder.decode(SavedPlaces.self, from: json)
            XCTAssertEqual(savedPlaces.places[0].coordinates.latitude, 34.1413891, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].coordinates.longitude, -118.1507140, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].title, "Select Physical Therapy")
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
            XCTFail()
        }
        
        
        
    }

}
