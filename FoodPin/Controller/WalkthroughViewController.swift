//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 16/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
  
  // MARK: - Properties
  @IBOutlet var pageControl: UIPageControl!
  @IBOutlet var nextButton: UIButton! {
    didSet {
      nextButton.layer.cornerRadius = 25.0
      nextButton.layer.masksToBounds = true
    }
  }
  @IBOutlet var skipButton: UIButton!
  
  var walkthroughPageViewController: WalkthroughPageViewController?
  
  // MARK: - Action Methods
  @IBAction func skipButtonTapped(sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButtonTapped(sender: UIButton) {
    if let index = walkthroughPageViewController?.currentIndex {
      switch index {
      case 0...1:
        walkthroughPageViewController?.forwardPage()
      case 2:
        dismiss(animated: true, completion: nil)
      default:
        break
      }
    }
    
    updateUI()
  }
  
  func updateUI() {
    if let index = walkthroughPageViewController?.currentIndex {
      switch index {
      case 0...1:
        nextButton.setTitle("NEXT", for: .normal)
        skipButton.isHidden = false
      case 2:
        nextButton.setTitle("GET STARTED", for: .normal)
        skipButton.isHidden = true
      default:
        break
      }
      
      pageControl.currentPage = index
    }
  }
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - WalkthroughPageViewControllerDelegate
  func didUpdatePageIndex(currentIndex: Int) {
    updateUI()
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destination = segue.destination
    if let pageViewController = destination as? WalkthroughPageViewController {
      walkthroughPageViewController = pageViewController
      walkthroughPageViewController?.walkthroughDelegate = self
    }
  }
}
