//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by Jonathan Tang on 10/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  open override var childViewControllerForStatusBarStyle: UIViewController? {
    return topViewController
  }
  
}
