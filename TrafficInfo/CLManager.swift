//
//  CLManager.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocatorDelegate: class {
    func locator(_ locator: Locator, didUpdateToLocations locations: [CLLocation])
    
}

public class Locator: NSObject, CLLocationManagerDelegate {
    public static let shared = Locator()
    weak var locDel: LocatorDelegate?
    
    
    func setup(delegate: LocatorDelegate) {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locDel = delegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        locationManager.startUpdatingLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locDel?.locator(self, didUpdateToLocations: locations)
    }
}
