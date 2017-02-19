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
    
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var coordinate : (Double, Double)!
    
    var phoneNumber : String?
    
    var id : String = ""
    
    var reviewArr : [NSDictionary] = [NSDictionary]()
    
    var business: Business!
    {
        didSet
        {
            nameLabel.text = business.name
            if(business.imageURL != nil)
            {
                businessImageView.setImageWith(business.imageURL!)
            }
            
            businessImageView.layer.cornerRadius = businessImageView.frame.size.width / 2
            businessImageView.clipsToBounds = true
            
            busBackView.layer.cornerRadius = busBackView.frame.size.width / 2
            busBackView.clipsToBounds = true
            
            categoryLabel.text = business.categories
            addressLabel.text = business.address
            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWith(business.ratingImageURL!)
            distanceLabel.text = business.distance
            phoneNumber = business.phoneNumber!
            coordinate = business.coordinate
            id = business.busId!
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        // Initialization code
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
