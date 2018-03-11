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
  @IBOutlet var closeButton: UIButton!
  
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
    
    let upTransform = CGAffineTransform.init(translationX: 0, y: -600)
    let rightTransform = CGAffineTransform.init(translationX: 600, y: 0)
    let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
    let moveScaleTransform = scaleUpTransform.concatenating(rightTransform)
    
    // Animate close button as 'slide-in-from-top'.
    closeButton.transform = upTransform
    closeButton.alpha = 0
    
    // Animate rating buttons as 'slide-in-from-right' with scaling.
    for rateButton in rateButtons {
      rateButton.transform = moveScaleTransform
      rateButton.alpha = 0
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    for i in 0...4 {
      let delay = 0.1 + 0.05 * Double(i)
      UIView.animate(withDuration: 0.4, delay: delay, options: [], animations: {
        self.rateButtons[i].alpha = 1.0
        self.rateButtons[i].transform = .identity
      }, completion: nil)
    }
    
    UIView.animate(withDuration: 0.4, delay: 0.7, options: [], animations: {
      self.closeButton.alpha = 1.0
      self.closeButton.transform = .identity
    }, completion: nil)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
}
