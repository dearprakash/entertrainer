//
//  SRAPIClient.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-07.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import CoreLocation

public struct IcoMera {
    static let base = "http://www.ombord.info/api/jsonp/position/?callback=function"
}

//Sample Response
/*
 function({
 "version":"1.9",
 "time":"1504851977",
 "age":"1",
 "latitude":"64.7499",
 "longitude":"20.035985",
 "altitude":"254.7",
 "speed":"36.126",
 "cmg":"0.0",
 "satellites":"12",
 "mode":"3"
 });
 */
extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}


open class IcomeraManager: NSObject {
    open static let shared = IcomeraManager()
    
    internal let manager: SessionManager = {
        var configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true
        configuration.urlCache = nil
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    open func currentCoordinates(completion: @escaping(_ coord: CLLocationCoordinate2D?) -> Void) {
        self.whereami { info in
            guard let info = info else { return }
            if let latitude = info["latitude"], let longitude = info["longitude"] {
                completion(CLLocationCoordinate2D(latitude: latitude.doubleValue, longitude: longitude.doubleValue))
            }
        }
    }
    
    open func whereami(
        completion: @escaping (_ entries: [String:String]?) -> Void) {
        var info: [String:String] = [:]
        
        self.manager.request(IcoMera.base).validate().responseString { response in
            if let string:String = response.result.value {
                var array = string.components(separatedBy: NSCharacterSet.newlines)
                array.removeFirst()
                array.removeLast()
                array.removeLast()
                for var item in array {
                    item = item.replacingOccurrences(of: "\"", with: "")
                    item = item.replacingOccurrences(of: " ", with: "")
                    item = item.replacingOccurrences(of: ",", with: "")
                    let inner = item.components(separatedBy: ":")
                    info[inner.first!] = inner.last!
                }
                completion(info)
            }
            
        }
    }
}
