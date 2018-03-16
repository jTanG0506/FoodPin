//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 16/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {

  var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE",
                      "SHOW YOU THE LOCATION",
                      "DISCOVER GREAT RESTAURANTS"]
  var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
  var pageSubheadings = ["Pin your favourite restaurant and create your own food guide",
                         "Search and locate your favourite restaurant on maps",
                         "Find restaurants shared by your friends and other foodies"]
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource = self
    
    if let startingViewController = contentViewController(at: 0) {
      setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
    }
  }
  
  // MARK: - UIPageViewControllerDataSource
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! WalkthroughContentViewController).index
    index -= 1
    
    return contentViewController(at: index)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    var index = (viewController as! WalkthroughContentViewController).index
    index += 1
    
    return contentViewController(at: index)
  }
  
  func contentViewController(at index: Int) -> WalkthroughContentViewController? {
    if index < 0 || index >= pageHeadings.count {
      return nil
    }
    
    // Create a new view controller and pass suitable data.
    let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
    if let pageContentViewController = storyboard.instantiateViewController(withIdentifier:
      "WalkthroughContentViewController")as? WalkthroughContentViewController {
      
      pageContentViewController.imageFile = pageImages[index]
      pageContentViewController.heading = pageHeadings[index]
      pageContentViewController.subheading = pageSubheadings[index]
      pageContentViewController.index = index
      
      return pageContentViewController
    }
    
    return nil
  }

}
