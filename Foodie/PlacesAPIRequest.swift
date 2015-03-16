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
    
    func getData(completion: ( (NSDictionary)->() ), failure: ( (NSError)->() )) {
        
        
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: url), queue: NSOperationQueue()) { (response, data, error) -> Void in
            
            if let connectionError = error {
                failure(connectionError)
            } else {
                var jsonDict: NSDictionary?
                var parseError : NSError?
                if let dataFromURL = data {
                    jsonDict = NSJSONSerialization.JSONObjectWithData(dataFromURL, options: nil, error: &parseError) as? NSDictionary
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completion(jsonDict!)
                    })
                } else {
                    failure(error!)
                }
            }
        }
    }

   
}
