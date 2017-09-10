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

public struct SRAPI {
    static let base = "https://api.sr.se/api/v2/traffic"
    static let areas = "/areas"
    static let messages = "/messages?trafficareaname=Stockholm"
}

open class NetworkManager: NSObject {
    open static let shared = NetworkManager()
    
    internal let manager: SessionManager = {
        var configuration = URLSessionConfiguration.default
        configuration.httpCookieAcceptPolicy = .always
        configuration.httpShouldSetCookies = true
        configuration.urlCache = nil
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Alamofire.SessionManager(configuration: configuration)
    }()

    open func loadAreas(
        completion: @escaping (_ areas: [Area]?, _ error: NSError?) -> Void) {
        let params: [String: Any] = ["format": "json", "size": 100]
        
        self.manager.request(SRAPI.base + SRAPI.areas, parameters: params).validate().responseJSON { response in
            guard let value = response.result.value as AnyObject? else {
                completion(nil, response.result.error as NSError?)
                return
            }
            
            if let areasJson = value["areas"] {
                completion(Mapper<Area>().mapArray(JSONObject: areasJson), nil)
            }
        }
    }
    
    open func loadMessages(
        completion: @escaping (_ areas: [Message]?, _ error: NSError?) -> Void) {
        var params: [String: Any] = ["format": "json", "size": 30]
        
        self.manager.request(SRAPI.base + SRAPI.messages, parameters: params).validate().responseJSON { response in
            guard let value = response.result.value as AnyObject? else {
                completion(nil, response.result.error as NSError?)
                return
            }
            
            if let messagesJson = value["messages"] {
                completion(Mapper<Message>().mapArray(JSONObject: messagesJson), nil)
            }
        }
    }
}
