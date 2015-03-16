//
//  Review.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/16/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class Review: NSObject {
    var author: String?
    var rating: Float?
    var text: String?
    
    init(author: String?, rating: Float?, text:String?) {
        self.author = author
        self.rating = rating
        self.text = text
    }
}
