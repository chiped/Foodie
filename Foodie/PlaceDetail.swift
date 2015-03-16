//
//  PlaceDetail.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/16/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class PlaceDetail: NSObject {
    var website: NSString?
    var ratingsCount: Int?
    var types: [String]?
    var openHours: [String]?
    var reviews: [Review]?
    
    init(website: NSString?, ratingsCount: Int?, types: [String]?, openHours: [String]?, reviews: [Review]?) {
        self.website = website
        self.ratingsCount = ratingsCount
        self.types = types
        self.openHours = openHours
        self.reviews = reviews
    }
}
