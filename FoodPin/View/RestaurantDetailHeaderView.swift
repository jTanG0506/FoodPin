//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Jonathan Tang on 09/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
  
  @IBOutlet var headerImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel! {
    didSet {
      nameLabel.numberOfLines = 0
    }
  }
  @IBOutlet var typeLabel: UILabel! {
    didSet {
      typeLabel.layer.cornerRadius = 5.0
      typeLabel.layer.masksToBounds = true
    }
  }
  @IBOutlet var heartImageView: UIImageView! {
    didSet {
      heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
      heartImageView.tintColor = .white
    }
  }
  
}
