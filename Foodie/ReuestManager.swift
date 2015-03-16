//
//  ReuestManager.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class ReuestManager: NSObject {
    
    class func getPlaces(completion: ([Place])->()) {
        let request = PlacesAPIRequest(type: .TextSearch, params: "query=restaurants%20newark%20delaware")
        var places = [Place]()
        
        let json = request.getData()
        
        if let status = json["status"] as? String {
            if(status == "OK") {
                if let placesArray = json["results"] as? [[String : AnyObject]] {
                    for placesDict in placesArray {
                        let name = placesDict["name"] as String
                        let placeid = placesDict["place_id"] as String
                        let rating = placesDict["rating"] as? Float
                        let priceLevel = placesDict["price_level"] as Int
                        let address = placesDict["formatted_address"] as String
                        let openNow = true
                        
                        
                        let place = Place(name: name, placeid: placeid, rating: rating ?? -1, priceLevel: priceLevel, address: address, openNow: openNow)
                        
                        places.append(place)
                    }
                }
            }
        }
        
        completion(places)
    }
   
}
