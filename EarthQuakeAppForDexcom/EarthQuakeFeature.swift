//
//  EarthQuakeFeature.swift
//  EarthQuakeAppForDexcom
//
//  Created by Nathan Chen on 28/06/2017.
//  Copyright © 2017 Nathan Chen. All rights reserved.
//

import Foundation
import ObjectMapper
struct EarthQuakeFeature:Mappable{
    var mag:Double?
    var id:String?
    var coordinates:[Double]?
    var title:String?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        mag <- map["properties.mag"]
        id <- map["id"]
        coordinates <- map["geometry.coordinates"]
        title <- map["properties.title"]
    }
    
}
