//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 16/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var pageControl: UIPageControl!
  @IBOutlet var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 25.0
      nextButton.layer.masksToBounds = true
    }
  }
  @IBOutlet var skipButton: UIButton!
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}
