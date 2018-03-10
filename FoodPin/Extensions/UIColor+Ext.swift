//
//  UIColor+Ext.swift
//  FoodPin
//
//  Created by Jonathan Tang on 10/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

extension UIColor {
  
  /// Initializes and returns a color object using the specified opacity and RGB component values.
  ///
  /// - Parameters:
  ///   - red: The red value of the color object.
  ///   - green: The green value of the color object.
  ///   - blue: The blue value of the color object.
  convenience init(red: Int, green: Int, blue: Int) {
    let redValue = CGFloat(red) / 255.0
    let greenValue = CGFloat(green) / 255.0
    let blueValue = CGFloat(blue) / 255.0
    
    self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
  }
  
}
