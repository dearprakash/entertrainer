//
//  SJLocation.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-08.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import ObjectMapper

class SJLocation: Mappable {
    open var name: String?
    open var image: String?
    open var locationDescription: String?
    open var lowPriceList: SJLowPriceList?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        name <- map["name"]
        image <- map["image"]
        locationDescription <- map["description"]
        lowPriceList <- map["lowPriceList"]
    }
}

class SJLowPriceList: Mappable {
    open var from: String?
    open var prices: [SJPrice]?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        from <- map["from"]
        prices <- map["prices"]
    }
}

class SJPrice: Mappable {
    open var date: String?
    open var price: Int?
    
    public required init?(map: ObjectMapper.Map) { }
    
    open func mapping(map: Map) {
        date <- map["date"]
        price <- map["price"]        
    }
}
