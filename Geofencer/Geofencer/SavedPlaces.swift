//
//  File.swift
//  Geofencer
//
//  Created by Brett Parsekian on 8/6/19.
//  Copyright © 2019 bparsekian. All rights reserved.
//

import Foundation

struct SavedPlaces {
    var places: [Place]
}

extension SavedPlaces: Decodable {
    private enum CodingKeys: String, CodingKey {
        case type = "type"
        case features = "features"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let features = try container.decode([Feature].self, forKey: .features)
        places = []
        for feature in features {
            let newPlace = Place(title: feature.properties.title,
                                 coordinates: feature.properties.location.geoCoordinates)
            places.append(newPlace)
        }
    }
}

struct Place: Decodable {
    let title: String
    let coordinates: GeoCoordinates
}

struct GeoCoordinates {
    var latitude : Double
    var longitude: Double
}

extension GeoCoordinates : Decodable {
    private enum CodingKeys: String, CodingKey {
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
    
    private enum CodingKeys: String, CodingKey {
        case geoCoordinates = "Geo Coordinates"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let gCoordinates = try container.decodeIfPresent(GeoCoordinates.self, forKey: .geoCoordinates)
        if gCoordinates == nil {
            let latitudeString = try container.decode(String.self, forKey: .latitude)
            let longitudeString = try container.decode(String.self, forKey: .longitude)
            geoCoordinates = GeoCoordinates(latitude : Double(latitudeString) ?? 0,
                                            longitude: Double(longitudeString) ?? 0)
        }
        else {
            geoCoordinates = gCoordinates ?? GeoCoordinates(latitude : 0, longitude: 0)
        }
    }
}

struct Properties : Decodable {
    let location: Location
    let title : String
    
    private enum CodingKeys: String, CodingKey {
        case location = "Location"
        case title = "Title"
    }
}

struct Feature : Decodable {
    let properties : Properties
    
    private enum CodingKeys: String, CodingKey {
        case properties = "properties"
    }
}
