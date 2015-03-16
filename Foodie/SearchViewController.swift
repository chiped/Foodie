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
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = places[indexPath.row].name
        return cell
    }
    
}
