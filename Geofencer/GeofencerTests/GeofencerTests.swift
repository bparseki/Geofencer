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
    let businessName: String
    let coordinates: GeoCoordinates
}

struct GeoCoordinates : Decodable {
    var latitude : Double
    var longitude: Double
    
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
    let businessName : String
    let geoCoordinates : GeoCoordinates
    
    enum CodingKeys: String, CodingKey {
        case businessName = "Business Name"
        case geoCoordinates = "Geo Coordinates"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        businessName = try container.decode(String.self, forKey: .businessName)
        geoCoordinates = try container.decode(GeoCoordinates.self, forKey: .geoCoordinates)
    }
}

struct Properties : Decodable {
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case location = "Location"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try container.decode(Location.self, forKey: .location)
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
        //let featuresContainer = try container.nestedContainer(keyedBy: CodingKeys.FeatureKeys.self, forKey: .features)
        features = try container.decode([Feature].self, forKey: .features)
        //let features = try container.decode([Feature].self, forKey: .features)
        places = []
        for feature in features {
            //print(feature)
            let newPlace = Place(businessName: feature.properties.location.businessName,
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
        
        let json = """
        {
            "type" : "FeatureCollection",
            "features" : [ {
                "geometry" : {
                    "coordinates" : [ -118.1507140, 34.1413891 ],
                    "type" : "Point"
                },
                "properties" : {
                  "Google Maps URL" : "http://maps.google.com/?cid=2075142942107850837",
                  "Location" : {
                    "Address" : "257 South Fair Oaks Avenue Suite 210, Pasadena, CA 91105, United States",
                    "Business Name" : "Select Physical Therapy",
                    "Country Code" : "US",
                    "Geo Coordinates" : {
                      "Latitude" : "34.1413891",
                      "Longitude" : "-118.1507140"
                    }
                  },
                  "Published" : "2018-11-02T22:43:17Z",
                  "Title" : "Select Physical Therapy",
                  "Updated" : "2018-11-02T22:43:17Z"
                },
                "type" : "Feature"
            }]
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        let geoPointAccuracy = 0.00001
        do {
            let savedPlaces = try decoder.decode(SavedPlaces.self, from: json)
            XCTAssertEqual(savedPlaces.places[0].coordinates.latitude, 34.1413891, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].coordinates.longitude, -118.1507140, accuracy: geoPointAccuracy)
            XCTAssertEqual(savedPlaces.places[0].businessName, "Select Physical Therapy")
            //all fine with jsonData here
        } catch {
            //handle error
            print(error)
            XCTFail()
        }
        
        
        
    }

}
