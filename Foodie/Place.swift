//
//  Place.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class Place: NSObject {
    var name:NSString?
    var placeid:NSString?
    var rating:Float?
    var priceLevel:NSString?
    var address:String?
    var openNow:Bool?
    var detail: PlaceDetail?
    
    init(name:NSString?, placeid:NSString?, rating:Float?, priceLevel:Int?, address:NSString?, openNow:Bool?) {
        self.name = name
        self.placeid = placeid
        self.rating = rating
        var priceLevelString = ""
        if let priceLevelInt = priceLevel {
            for _ in 1 ... priceLevelInt {
                priceLevelString += "$"
            }
        }
        self.priceLevel = priceLevelString
        self.address = address?.stringByReplacingOccurrencesOfString(", United States", withString: "")
        self.openNow = openNow
        super.init()
    }
}
