//
//  MappViewController.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, LocatorDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var messages: [Message]?
    
    var stations: [SJStation] = []
    var locator: Locator = Locator.shared
    static let storyboardIdentifier = "MapViewControllerStoryBoardIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        locator.setup(delegate: self)

        NetworkManager.shared.loadMessages { (msgs, err) in
            self.messages = msgs
            self.addTrafficMessageAnnotations()
        }
        
        StationsAlongRoute.shared.loadRouteInfo { (stations, error) in
            if let stations = stations {
                self.stations = stations
                self.addStationAnnotations()
            }
        }
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func addStationAnnotations() {
        for station in stations {
            let coord = CLLocationCoordinate2D(latitude: (station.latitude?.doubleValue)!,
                                               longitude: (station.longitude?.doubleValue)!)
            let ann = SJStationAnnotation(title: station.locationName!, locationName: (station.arrival?.Time)!, arrival: (station.arrival?.date)!, coordinate: coord)
            self.map.addAnnotation(ann)
        }
    }
    
    func addTrafficMessageAnnotations() {
        if let messages = messages {
            for message in messages {
                let coord = CLLocationCoordinate2D(latitude: message.latitude!,
                                                   longitude: message.longitude!)
                let ann = MKPointAnnotation()
                ann.coordinate = coord
                ann.title = message.messageDescription
                ann.subtitle = message.title
                self.map.addAnnotation(ann)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        else if let annotation = annotation as? SJStationAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.pinTintColor = .blue
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var coord = CLLocationCoordinate2D()
        
        if let ann = view.annotation as? SJStationAnnotation {
            coord = ann.coordinate
        } else if let userloc = view.annotation as? MKUserLocation {
            coord = userloc.coordinate
        }

        StationsAlongRoute.shared.loadHereInfo(lat:coord.latitude , lng: coord.longitude) { (sjlocation) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let hereVC = storyboard.instantiateViewController(withIdentifier: "hereviewcontroller") as? HereViewController else {
                fatalError("Unable to instatiate MapView.")
            }
            hereVC.here = sjlocation
            self.navigationController?.pushViewController(hereVC, animated: true)
        }
    }
    
    func locator(_ locator: Locator, didUpdateToLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        centerMapOnLocation(location: location)
    }
}
