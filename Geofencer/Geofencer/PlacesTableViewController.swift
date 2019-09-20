//
//  PlacesTableViewController.swift
//  Geofencer
//
//  Created by Brett Parsekian on 8/23/19.
//  Copyright © 2019 bparsekian. All rights reserved.
//

import Foundation
import UIKit
import WKZombie

class PlacesTableViewController: UITableViewController {
    
    var places: [Place] = PlacesDecoder.fetchPlaces()
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        cell.textLabel?.text = place.title
        return cell
    }
}
