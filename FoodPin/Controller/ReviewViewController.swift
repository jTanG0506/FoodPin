//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 11/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var backgroundImageView: UIImageView!
  
  var restaurant = Restaurant()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImageView.image = UIImage(named: restaurant.image)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
