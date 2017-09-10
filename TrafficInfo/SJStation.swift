//
//  SJStation.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import ObjectMapper

open class SJArrival: Mappable {
    open var date: String?
    open var IsCancelled: Bool?
    open var IsDelayed: Bool?
    open var IsMarkDelayed: Bool?
    open var PreviousTrack: String?
    open var RealDate: String?
    open var RealTime: String?
    open var RealTimeInformation: String?
    open var Time: String?
    open var Track: String?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        date <- map["Date"]
        IsCancelled <- map["IsCancelled"]
        IsDelayed <- map["IsDelayed"]
        IsMarkDelayed <- map["IsMarkDelayed"]
        PreviousTrack <- map["PreviousTrack"]
        RealDate <- map["RealDate"]
        RealTime <- map["RealTime"]
        RealTimeInformation <- map["RealTimeInformation"]
        Time <- map["Time"]
        Track <- map["Track"]
    }
}

open class SJStation: Mappable {
    open var locationCode: String?
    open var locationName: String?
//    open var IsMarkDelayed: Bool?
//    open var isDelayed: Bool?
    open var latitude: String?
    open var longitude: String?
    
    open var arrival: SJArrival?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        locationCode <- map["LocationCode"]
        locationName <- map["LocationName"]
        latitude <- map["Latitude"]
        longitude <- map["Longitude"]
        arrival <- map["Arrival"]
    }
}
