//
//  RatingTableViewCell.swift
//  FoodTracker
//
//  Created by Administrator on 07/01/16.
//  Copyright © 2016 Administrator. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    // Mark: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
