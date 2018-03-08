//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 08/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  
  var restaurant: Restaurant = Restaurant()
  
  @IBOutlet weak var restaurantImageView: UIImageView!
  @IBOutlet weak var restaurantNameLabel: UILabel!
  @IBOutlet weak var restaurantTypeLabel: UILabel!
  @IBOutlet weak var restaurantLocationLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    
    restaurantImageView.image = UIImage(named: restaurant.image)
    restaurantNameLabel.text = restaurant.name
    restaurantTypeLabel.text = restaurant.type
    restaurantLocationLabel.text = restaurant.location
  }
  
}
