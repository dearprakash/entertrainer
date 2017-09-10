//
//  TrafficArea.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-07.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation

import ObjectMapper

open class Area: Mappable {
    open var name: String?
    open var trafficdepartmentunitid: Int?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        name <- map["name"]
        trafficdepartmentunitid <- map["trafficdepartmentunitid"]
    }

}
