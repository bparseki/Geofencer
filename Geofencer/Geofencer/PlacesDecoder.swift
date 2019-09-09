//
//  PlacesDecoder.swift
//  Geofencer
//
//  Created by Brett Parsekian on 8/23/19.
//  Copyright © 2019 bparsekian. All rights reserved.
//

import Foundation

struct PlacesDecoder {
    static func fetchPlaces() -> [Place] {
        let filename = "Saved Places"
        let fileExt = "json"
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileExt) else { return []}
        guard let json = try? Data(contentsOf: url) else { return []}
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(SavedPlaces.self, from: json).places
        } catch {
            //handle error
            print(error)
        }
        return []
    }
}
