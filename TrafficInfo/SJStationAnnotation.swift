//
//  SJStationAnnotation.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import MapKit

class SJStationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let arrival: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, arrival: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.arrival = arrival
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
