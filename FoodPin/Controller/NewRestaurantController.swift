//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 12/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
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
  
  @IBOutlet var photoImageView: UIImageView!
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure navigation bar appearance
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    if let customFont = UIFont(name: "Rubik-Medium", size: 35.0) {
      navigationController?.navigationBar.largeTitleTextAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
        NSAttributedStringKey.font: customFont
      ]
    }
  }
  
  @IBAction func saveButtonTapped(sender: AnyObject) {
    if nameTextField.text == "" || typeTextField.text == "" || addressTextField.text == "" ||
      phoneTextField.text == "" || descriptionTextView.text == "" {
      let alertController = UIAlertController(title: "Invalid fields", message: "Please fill out all fields.", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(alertAction)
      
      present(alertController, animated: true, completion: nil)
      
      return
    }
    
    print("Name: \(nameTextField.text ?? "")")
    print("Type: \(typeTextField.text ?? "")")
    print("Location: \(addressTextField.text ?? "")")
    print("Phone: \(phoneTextField.text ?? "")")
    print("Description: \(descriptionTextView.text ?? "")")
    
    dismiss(animated: true, completion: nil)
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
  
  // MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source",
                                                           preferredStyle: .actionSheet)
      
      let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .camera
          
          self.present(imagePicker, animated: true, completion: nil)
        }
      })
      
      let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          let imagePicker = UIImagePickerController()
          imagePicker.delegate = self
          imagePicker.allowsEditing = false
          imagePicker.sourceType = .photoLibrary
          
          self.present(imagePicker, animated: true, completion: nil)
        }
      })
      
      photoSourceRequestController.addAction(cameraAction)
      photoSourceRequestController.addAction(photoLibraryAction)
      
      present(photoSourceRequestController, animated: true, completion: nil)
    }
  }
  
  // MARK: - UIImagePickerControllerDelegate
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      photoImageView.image = selectedImage
      photoImageView.contentMode = .scaleAspectFill
      photoImageView.clipsToBounds = true
    }
    
    let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .leading, relatedBy: .equal, toItem: photoImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
    leadingConstraint.isActive = true
    
    let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: .trailing, relatedBy: .equal, toItem: photoImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
    trailingConstraint.isActive = true
    
    let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: .top, relatedBy: .equal, toItem: photoImageView.superview, attribute: .top, multiplier: 1, constant: 0)
    topConstraint.isActive = true
    
    let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: .bottom, relatedBy: .equal, toItem: photoImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
    bottomConstraint.isActive = true
    
    dismiss(animated: true, completion: nil)
  }
}
