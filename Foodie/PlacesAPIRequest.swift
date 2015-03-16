//
//  PlacesAPIRequest.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

enum URLType : String {
    case Nearby = "nearbysearch/", TextSearch = "textsearch/", Details = "details/", AutoComplete = "autocomplete/"
}

class PlacesAPIRequest {
    
    var url:NSURL
    
    init(type: URLType, params: NSString) {
        let url =  Constants.baseURL + type.rawValue + Constants.format + params + Constants.apiKey
        
        self.url = NSURL(string: url)!
    }
    
    func getData() -> NSDictionary {
        let dataFromURL = NSData(contentsOfURL: url)
        var error : NSError?
        var jsonDict: NSDictionary?
        if let data = dataFromURL {
            jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? NSDictionary
        }
        return jsonDict!
    }

   
}
