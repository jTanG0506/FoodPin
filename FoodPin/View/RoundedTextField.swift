//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by Jonathan Tang on 12/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
  
  let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, padding)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.layer.cornerRadius = 5.0
    self.layer.masksToBounds = true
  }
  
}
