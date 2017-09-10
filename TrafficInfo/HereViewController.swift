//
//  HereViewController.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class HereViewController: UIViewController{
    @IBOutlet weak var locationName: UILabel!
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationDescription: UILabel!
    
    var here: SJLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationName.text = here?.name
        self.locationDescription.text = here?.locationDescription
        if let imageurl = here?.image {
            if let url = URL(string: imageurl) {
                self.locationImage.af_setImage(withURL: url, placeholderImage: UIImage(named:""), filter: nil, progress: nil, runImageTransitionIfCached: true, completion: nil)
            }
        }
        
        if let arr = here?.lowPriceList {
            print(arr)
        }
    }
}
