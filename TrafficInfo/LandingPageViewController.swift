//
//  LandingPageViewController.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LandingPageViewController: UIViewController {
    
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var lowPriceButton: UIButton!
    
    override func viewDidLoad() {
    }
    
    @IBAction func handleRouteButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(withIdentifier: MapVC.storyboardIdentifier) as? MapVC else {
            fatalError("Unable to instatiate MapView.")
        }
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @IBAction func handleLowPriceButton(_ sender: Any) {
    }
}
