//
//  SearchViewController.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var resultsTableView: UITableView!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReuestManager.getPlaces { (places) -> () in
            self.places.extend(places)
            self.resultsTableView.reloadData()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as SearchResultsView
        
        let place = places[indexPath.row]
        
        cell.nameLabel.text = place.name
        cell.addressLabel.text = place.address
        var priceLevel = ""
        for _ in 1 ... place.priceLevel {
            priceLevel += "$"
        }
        cell.priceLevelLabel.text = priceLevel
        
        return cell
    }
    
}
