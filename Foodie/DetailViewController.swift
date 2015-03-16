//
//  DetailViewController.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/15/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var priceLevelLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var detailsTable: UITableView!
    @IBOutlet weak var ratingView: RatingView!
    
    var place: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        self.title = place?.name
        addressLabel.text = place?.address
        priceLevelLabel.text = place?.priceLevel
        ratingView.rating = place?.rating
        RequestManager.getPlaceDetails(place!, completion: { () -> () in
            if let ratingCount = self.place?.detail?.ratingsCount as Int? {
                self.reviewCountLabel.text = "\(ratingCount) reviews"
            }
            self.phoneTextView.text = self.place?.detail?.phone
            self.detailsTable.reloadData()
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if let placeDetail = place?.detail {
                return placeDetail.openHours?.count ?? 0
            }
        } else if section == 1 {
            if let placeReviews = place?.detail?.reviews {
                return placeReviews.count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return cellForWorkHours(indexPath, tableView: tableView)
        } else {
            return cellForReview(indexPath, tableView: tableView)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Work hours" : "Reviews"
    }
    
    func cellForWorkHours(indexPath: NSIndexPath, tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("workHoursCell", forIndexPath: indexPath) as WorkHoursCell
        cell.workHoursLabel.text = place?.detail?.openHours?[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "e"
        let today = dateFormatter.stringFromDate(NSDate())
        cell.textLabel.textColor = today == "\(indexPath.row)" ? UIColor.blackColor() : UIColor.grayColor()
        return cell
    }
    
    func cellForReview(indexPath: NSIndexPath, tableView: UITableView) -> ReviewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewCell", forIndexPath: indexPath) as ReviewCell
        cell.nameLabel.text = place?.detail?.reviews?[indexPath.row].author
        cell.ratingLabel.text = "\(place?.detail?.reviews?[indexPath.row].rating as Float!) stars"
        cell.reviewTextLabel.text = place?.detail?.reviews?[indexPath.row].text
        return cell
    }

}
