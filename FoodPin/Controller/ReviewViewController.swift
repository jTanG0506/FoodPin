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
  @IBOutlet var rateButtons: [UIButton]!
  
  var restaurant = Restaurant()
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    backgroundImageView.image = UIImage(named: restaurant.image)
    
    // Apply blur effect
    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    backgroundImageView.addSubview(blurEffectView)
    
    // Animate buttons as 'fade-in'.
    for rateButton in rateButtons {
      rateButton.alpha = 0
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
      self.rateButtons[0].alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.4, delay: 0.15, options: [], animations: {
      self.rateButtons[1].alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.4, delay: 0.2, options: [], animations: {
      self.rateButtons[2].alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.4, delay: 0.25, options: [], animations: {
      self.rateButtons[3].alpha = 1.0
    }, completion: nil)
    
    UIView.animate(withDuration: 0.4, delay: 0.3, options: [], animations: {
      self.rateButtons[4].alpha = 1.0
    }, completion: nil)
  }
  
}
