//
//  Place.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class Place: NSObject {
    var name:NSString
    var placeid:NSString
    var rating:Float
    var priceLevel:Int
    var address:String
    var openNow:Bool
    
    init(name:NSString, placeid:NSString, rating:Float, priceLevel:Int, address:NSString, openNow:Bool) {
        self.name = name
        self.placeid = placeid
        self.rating = rating
        self.priceLevel = priceLevel
        self.address = address
        self.openNow = openNow
        super.init()
    }
}
