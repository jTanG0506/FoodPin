//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 12/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate {
  
  // MARK: - Properties
  @IBOutlet var nameTextField: RoundedTextField! {
    didSet {
      nameTextField.tag = 1
      nameTextField.becomeFirstResponder()
      nameTextField.delegate = self
    }
  }
  
  @IBOutlet var typeTextField: RoundedTextField! {
    didSet {
      typeTextField.tag = 2
      typeTextField.delegate = self
    }
  }
  
  @IBOutlet var addressTextField: RoundedTextField! {
    didSet {
      addressTextField.tag = 3
      addressTextField.delegate = self
    }
  }
  
  @IBOutlet var phoneTextField: RoundedTextField! {
    didSet {
      phoneTextField.tag = 4
      phoneTextField.delegate = self
    }
  }
  
  @IBOutlet var descriptionTextView: UITextView! {
    didSet {
      descriptionTextView.tag = 5
      descriptionTextView.layer.cornerRadius = 5.0
      descriptionTextView.layer.masksToBounds = true
    }
  }
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // Move the focus onto the next text field, if there is one.
    if let nextTextField = view.viewWithTag(textField.tag + 1) {
      textField.resignFirstResponder()
      nextTextField.becomeFirstResponder()
    }
    
    return true
  }
}
