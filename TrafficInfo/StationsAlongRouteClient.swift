//
//  StationsAlongRouteClient.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


public struct Routes {
    static let baseurl = "http://entertrainment-env.eu-west-1.elasticbeanstalk.com/api/"
    static let route = "traffic/trainroute/92?dateTime=2017-09-07T18:30:00"
    static let here = "locations/search"
}
class StationsAlongRoute {
    public static let shared = StationsAlongRoute()
    
    internal let manager: SessionManager = {
        var configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true
        configuration.urlCache = nil
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    open func loadHereInfo(lat: Double, lng: Double, completion: @escaping (_ loc: SJLocation?) -> Void) {
        let params: [String: Any] = ["lat": "\(lat)", "lon": "\(lng)"]

        self.manager.request(Routes.baseurl + Routes.here, parameters: params).validate().responseJSON { (response) in
            guard let value = response.result.value as AnyObject? else {
                completion(nil)
                return
            }
            
            let stationsJson = value
            completion(Mapper<SJLocation>().map(JSONObject: stationsJson))
        }
    }
    
    open func loadRouteInfo(
        completion: @escaping (_ areas: [SJStation]?, _ error: NSError?) -> Void) {
        
        self.manager.request(Routes.baseurl+Routes.route).validate().responseJSON { response in
            guard let value = response.result.value as AnyObject? else {
                completion(nil, response.result.error as NSError?)
                return
            }
            
            if let stationsJson = value["Stations"] {
                completion(Mapper<SJStation>().mapArray(JSONObject: stationsJson), nil)
            }
        }
    }
}
