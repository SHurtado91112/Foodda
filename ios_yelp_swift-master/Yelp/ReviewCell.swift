//
//  ReviewCell.swift
//  Yelp
//
//  Created by Steven Hurtado on 2/18/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell
{

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    var nameText : String?
    
    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var excerptLabel: UILabel!
    var excerptText : String?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        cellView.layer.shadowColor = UIColor.myOnyxGray.cgColor
        cellView.layer.shadowRadius = 10
        cellView.layer.shadowOpacity = 1.0
        cellView.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cellView.layer.shouldRasterize = true
        
        nameLabel.text = nameText
        excerptLabel.text = excerptText
        
        avatarImgView.layer.cornerRadius = avatarImgView.frame.size.width / 2
        avatarImgView.layer.borderWidth = 4
        avatarImgView.layer.borderColor = UIColor.mySalmonRed.cgColor
        avatarImgView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
