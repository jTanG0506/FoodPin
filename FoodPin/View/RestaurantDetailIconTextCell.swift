//
//  RestaurantDetailIconTextCell.swift
//  FoodPin
//
//  Created by Jonathan Tang on 09/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantDetailIconTextCell: UITableViewCell {
  
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet var shortTextLabel: UILabel! {
    didSet {
      shortTextLabel.numberOfLines = 0
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}
