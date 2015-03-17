//
//  SearchViewController.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var retryView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
    }
    
    func getLocation() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.distanceFilter = kCLDistanceFilterNone
            locationManager?.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    func loadData() {
        self.loadingView.hidden = false
        self.spinner.startAnimating()
        self.resultsTableView.hidden = true
        self.retryView.hidden = true
        
        RequestManager.getPlacesNear(lastLocation, { (places) -> () in
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
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        let alert = UIAlertView(title: "Error", message: "Failed to get your location", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if let currentLocation = newLocation {
            lastLocation = currentLocation
            println("We are at lat = \(currentLocation.coordinate.latitude) and long = \(currentLocation.coordinate.longitude)")
            manager.stopUpdatingLocation()
            loadData()
        }
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
