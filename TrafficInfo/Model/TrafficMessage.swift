//
//  TrafficMessage.swift
//  TrafficInfo
//
//  Created by Prakash Rajendran on 2017-09-07.
//  Copyright © 2017 Sveriges Radio AB. All rights reserved.
//

import Foundation
import ObjectMapper

//"id": 2025032,
//"priority": 3,
//"createddate": "\/Date(1502774359257+0200)\/",
//"title": "E6 Halmstad–Ängelholm",
//"exactlocation": "Skottorp, båda riktningar",
//"description": "Reparation av bro. Endast ett körfält öppet i vardera riktningen.",
//"latitude": 56.447353363037109,
//"longitude": 12.952640533447266,
//"category": 0,
//"subcategory": "Vägarbete"

open class Message: NSObject, Mappable {
    var identifier: Int?
    var priority: Int?
    var createdDate: String?
    var title: String?
    var latitude: Double?
    var longitude: Double?
    var exactLocation: String?
    var messageDescription: String?
    var subcategory: String?
    
    public required init?(map: ObjectMapper.Map) { }
    
    public func mapping(map: Map) {
        identifier <- map["id"]
        priority <- map["priority"]
        createdDate <- map["createdDate"]
        title <- map["title"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        exactLocation <- map["exactLocation"]
        messageDescription <- map["description"]
        subcategory <- map["subcategory"]
    }
}
