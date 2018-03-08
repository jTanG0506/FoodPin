//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 08/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
  
  var restaurantImageName = ""  
  @IBOutlet weak var restaurantImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    
    restaurantImageView.image = UIImage(named: restaurantImageName)
  }
  
}
