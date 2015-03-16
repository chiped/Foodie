//
//  RatingView.swift
//  Foodie
//
//  Created by Pednekar, Chinmay on 3/16/15.
//  Copyright (c) 2015 chinmay. All rights reserved.
//

import UIKit

class RatingView: UIView {

    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    var rating:Float? {
        didSet {
            if let _ = rating {
                configureView()
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let nib = NSBundle.mainBundle().loadNibNamed("RatingView", owner: self, options: nil) as? [UIView]        
        self.addSubview(nib![0])
    }
    
    func configureView() {
        let stars = [star1, star2, star3, star4, star5]
        
        for i in 0..<stars.count {
            var diff = rating! - Float(i)
            if diff <= 0 {
                stars[i]?.image = UIImage(named: "emptyStar")
            } else if diff <= 0.9 {
                stars[i]?.image = UIImage(named: "halfStar")
            } else {
                stars[i]?.image = UIImage(named: "fullStar")
            }
        }
        
        self.setNeedsDisplay()
    }

}
