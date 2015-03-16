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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var retryView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        self.loadingView.hidden = false
        self.spinner.startAnimating()
        self.resultsTableView.hidden = true
        self.retryView.hidden = true
        
        RequestManager.getPlaces( { (places) -> () in
            self.loadingView.hidden = true
            self.spinner.stopAnimating()
            self.resultsTableView.hidden = false
            self.retryView.hidden = true
            self.places.extend(places)
            self.resultsTableView.reloadData()
            }, { (error: NSError) -> () in
                self.loadingView.hidden = true
                self.spinner.stopAnimating()
                self.resultsTableView.hidden = true
                self.retryView.hidden = false
        })
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
        cell.priceLevelLabel.text = place.priceLevel
        cell.ratingView.rating = place.rating
                
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showDetailSegue", sender: places[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let place = sender as? Place
        let destinationVC = segue.destinationViewController as? DetailViewController
        destinationVC?.place = place
    }
    
    @IBAction func onClickRetry(sender: AnyObject) {
        loadData()
    }
    
}
