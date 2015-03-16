//
//  RequestManager.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class RequestManager {
    
    class func getPlaces(completion: ([Place])->()) {
        let request = PlacesAPIRequest(type: .TextSearch, params: "query=restaurants%20newark%20delaware")
        var places = [Place]()
        
        request.getData({ (json: NSDictionary) -> () in
            
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
                    completion(places)
                }
            }
            
            }, failure: { (NSError) -> () in
                
        })
        
        
    }
    
    class func getPlaceDetails(place: Place, completion: ( ()->() ) ) {
        let request = PlacesAPIRequest(type: .Details, params: "placeid="+place.placeid)
        
        request.getData({ (json: NSDictionary) -> () in
            
            if let status = json["status"] as? String {
                if(status == "OK") {
                    if let resultJson = json["result"] as? [String : AnyObject] {
                        let phoneNumber = resultJson["formatted_phone_number"] as String
                        let website = resultJson["website"] as String
                        let openHoursJson = resultJson["opening_hours"] as [String : AnyObject]
                        let openHours = openHoursJson["weekday_text"] as [String]
                        let ratingCount = resultJson["user_ratings_total"] as Int
                        
                        var reviews = [Review]()
                        
                        let reviewsArray = resultJson["reviews"] as [ [String : AnyObject] ]
                        for reviewsDict in reviewsArray {
                            let author = reviewsDict["author_name"] as? String
                            let text = reviewsDict["text"] as? String
                            let rating = reviewsDict["rating"] as? Float
                            
                            let review = Review(author: author, rating: rating, text: text)
                            reviews.append(review)
                        }
                        
                        place.detail = PlaceDetail(website: website, ratingsCount: ratingCount, types: nil, openHours: openHours, reviews: reviews)                        
                    }
                    completion()
                }
            }
            }, failure: { (NSError) -> () in
                
        })

    }
}
