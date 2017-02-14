//
//  BusinessCell.swift
//  Yelp
//
//  Created by Steven Hurtado on 2/13/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell
{

    @IBOutlet weak var businessImageView: UIImageView!
    
    @IBOutlet weak var busBackView: UIView!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var moniesLabel: UILabel!
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business!
    {
        didSet
        {
            nameLabel.text = business.name
            businessImageView.setImageWith(business.imageURL!)
            businessImageView.layer.cornerRadius = businessImageView.frame.size.width / 2
            businessImageView.clipsToBounds = true
            
            busBackView.layer.cornerRadius = busBackView.frame.size.width / 2
            busBackView.clipsToBounds = true
            
            categoryLabel.text = business.categories
            addressLabel.text = business.address
            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
            
            let rand = Int(arc4random_uniform(4)+1)
            
            switch(rand)
            {
                case 1:
                    moniesLabel.text = "$"
                    break;
                case 2:
                    moniesLabel.text = "$$"
                    break;
                case 3:
                    moniesLabel.text = "$$$"
                    break;
                case 4:
                    moniesLabel.text = "$$$$"
                    break;
                default:
                    break;
            }
            
            
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
