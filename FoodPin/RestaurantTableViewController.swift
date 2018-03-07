//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 06/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
  
  var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
                         "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
                         "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso",
                         "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf",
                         "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
                         "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
  
  var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl",
                          "petiteoyster", "forkeerestaurant", "posatelier",
                          "bourkestreetbakery", "haighschocolate", "palominoespresso",
                          "upstate", "traif", "grahamavenuemeats", "wafflewolf",
                          "fiveleaves", "cafelore", "confessional", "barrafina",
                          "donostia", "royaloak", "caskpubkitchen"]
  
  var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                             "Hong Kong", "Hong Kong", "Hong Kong",
                             "Sydney", "Sydney", "Sydney",
                             "New York", "New York", "New York", "New York",
                             "New York", "New York", "New York", "London",
                             "London", "London", "London"]
  
  var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink",
                         "French", "Bakery", "Bakery", "Chocolate",
                         "Cafe", "American / Seafood", "American",
                         "American", "Breakfast & Brunch", "Coffee & Tea",
                         "Coffee & Tea", "Latin American", "Spanish", "Spanish",
                         "Spanish", "British", "Thai"]
  
  var restaurantIsVisited = Array(repeating: false, count: 21)
 
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.cellLayoutMarginsFollowReadableWidth = true
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantNames.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurantNames[indexPath.row]
    cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
    cell.typeLabel.text = restaurantTypes[indexPath.row]
    cell.locationLabel.text = restaurantLocations[indexPath.row]
    cell.heartImageView.isHidden = !restaurantIsVisited[indexPath.row]
    
    cell.selectionStyle = .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    
    // Provide sourceView and sourceRect for iPad.
    if let popoverController = optionMenu.popoverPresentationController {
      if let cell = tableView.cellForRow(at: indexPath) {
        popoverController.sourceView = cell
        popoverController.sourceRect = cell.bounds
      }
    }
    
    // Cancel action.
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    optionMenu.addAction(cancelAction)

    // Call action.
    let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .default) { (action) in
      let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet", preferredStyle: .alert)
      alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alertMessage, animated: true, completion: nil)
    }
    optionMenu.addAction(callAction)
    
    // Check in action.
    let checkInTitle = restaurantIsVisited[indexPath.row] ? "Undo Check in" : "Check in"
    let checkInAction = UIAlertAction(title: checkInTitle, style: .default) { (action) in
      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
      self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
      cell.heartImageView.isHidden = !self.restaurantIsVisited[indexPath.row]
    }
    optionMenu.addAction(checkInAction)
    
    tableView.deselectRow(at: indexPath, animated: false)
    
    present(optionMenu, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    // Delete the row from the data source
    if editingStyle == .delete {

    }
    
    
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "") {
      (action, sourceView, completionHandler) in
      
      self.restaurantNames.remove(at: indexPath.row)
      self.restaurantImages.remove(at: indexPath.row)
      self.restaurantLocations.remove(at: indexPath.row)
      self.restaurantTypes.remove(at: indexPath.row)
      self.restaurantIsVisited.remove(at: indexPath.row)
      
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "") {
      (action, sourceView, completionHandler) in
      
      let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
      let activityController: UIActivityViewController
      
      if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
        activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
      } else {
        activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
      }
      
      // Provide sourceView and sourceRect for iPad.
      if let popoverController = activityController.popoverPresentationController {
        if let cell = tableView.cellForRow(at: indexPath) {
          popoverController.sourceView = cell
          popoverController.sourceRect = cell.bounds
        }
      }

      self.present(activityController, animated: true, completion: nil)
      completionHandler(true)
    }
    
    // Customise appearance of actions
    deleteAction.backgroundColor = UIColor(red: 231.0 / 255.0, green: 76.0 / 255.0, blue: 60.0 / 255.0, alpha: 1.0)
    deleteAction.image = UIImage(named: "delete")
    shareAction.backgroundColor = UIColor(red: 254.0 / 255.0, green: 149.0 / 255.0, blue: 38.0 / 255.0, alpha: 1.0)
    shareAction.image = UIImage(named: "share")
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    return swipeConfiguration
  }
}
