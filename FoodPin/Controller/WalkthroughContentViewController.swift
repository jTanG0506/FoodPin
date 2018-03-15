//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 15/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var headingLabel: UILabel! {
    didSet {
      headingLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet var subHeadingLabel: UILabel! {
    didSet {
      subHeadingLabel.numberOfLines = 0
    }
  }
  
  @IBOutlet var contentImageView: UIImageView!
  
  var index = 0
  var heading = ""
  var subheading = ""
  var imageFile = ""
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    headingLabel.text = heading
    subHeadingLabel.text = subheading
    contentImageView.image = UIImage(named: imageFile)
  }
  
}
