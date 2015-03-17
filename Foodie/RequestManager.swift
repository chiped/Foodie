//
//  RequestManager.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit
import CoreLocation

class RequestManager {
    
    class func getPlacesNear(location:CLLocation, completion: ([Place])->(), failure: (NSError) -> () ) {
        let query = "location=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=5000&types=food|restaurant"
        getPlacesData(query, type:.Nearby, completion: completion, failure: failure)
    }
    
    class func getPlaces(keyword:String, location:CLLocation?, completion: ([Place])->(), failure: (NSError) -> () ) {
        var query = "query=keyword&types=food|restaurant"
        if let currentLocation = location {
            query += "&location=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&radius=5000"
        }
        getPlacesData(query, type:.TextSearch, completion: completion, failure: failure)
    }
    
    class func getPlaces(completion: ([Place])->(), failure: (NSError) -> () ) {
        let query = "query=restaurants%20newark%20delaware"
        getPlacesData(query, type:.TextSearch, completion: completion, failure: failure)
    }
    
    private class func getPlacesData(query: String, type: URLType, completion: ([Place])->(), failure: (NSError) -> () ) {
        let request = PlacesAPIRequest(type: type, params: query)
        var places = [Place]()
        
        request.getData({ (json: NSDictionary) -> () in
            
            if let status = json["status"] as? String {
                if(status == "OK") {
                    if let placesArray = json["results"] as? [[String : AnyObject]] {
                        for placesDict in placesArray {
                            let name = placesDict["name"] as? String
                            let placeid = placesDict["place_id"] as? String
                            let rating = placesDict["rating"] as? Float
                            let priceLevel = placesDict["price_level"] as? Int
                            let address = placesDict["formatted_address"] as? String
                            let openNow = true
                            
                            
                            let place = Place(name: name, placeid: placeid, rating: rating, priceLevel: priceLevel, address: address, openNow: openNow)
                            
                            places.append(place)
                        }
                    }
                    completion(places)
                } else {
                    failure(NSError())
                }
            }
            }, failure: failure)
    }
    
    class func getPlaceDetails(place: Place, completion: ( ()->() ) ) {
        let request = PlacesAPIRequest(type: .Details, params: "placeid="+place.placeid!)
        
        request.getData({ (json: NSDictionary) -> () in
            
            if let status = json["status"] as? String {
                if(status == "OK") {
                    if let resultJson = json["result"] as? [String : AnyObject] {
                        let phoneNumber = resultJson["formatted_phone_number"] as? String
                        let website = resultJson["website"] as? String
                        let openHoursJson = resultJson["opening_hours"] as? [String : AnyObject]
                        let openHours = openHoursJson?["weekday_text"] as [String]
                        let ratingCount = resultJson["user_ratings_total"] as? Int
                        
                        var reviews = [Review]()
                        
                        if let reviewsArray = resultJson["reviews"] as? [ [String : AnyObject] ] {
                            for reviewsDict in reviewsArray {
                                let author = reviewsDict["author_name"] as? String
                                let text = reviewsDict["text"] as? String
                                let rating = reviewsDict["rating"] as? Float
                                
                                let review = Review(author: author, rating: rating, text: text)
                                reviews.append(review)
                            }
                        }
                        
                        place.detail = PlaceDetail(phone: phoneNumber, website: website, ratingsCount: ratingCount, types: nil, openHours: openHours, reviews: reviews)
                    }
                    completion()
                }
            }
            }, failure: { (NSError) -> () in
                
        })

    }
}
