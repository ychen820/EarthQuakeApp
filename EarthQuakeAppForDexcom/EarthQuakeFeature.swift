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
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        mag <- map["propoerties.mag"]
        id <- map["id"]
    }
    
}
