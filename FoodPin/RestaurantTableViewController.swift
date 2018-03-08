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
    navigationController?.navigationBar.prefersLargeTitles = true
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
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let toggleAction = UIContextualAction(style: .normal, title: "") {
      (action, sourceView, completionHandler) in
      
      self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
      cell.heartImageView.isHidden = !self.restaurantIsVisited[indexPath.row]
      
      completionHandler(true)
    }
    
    // Display the appropriate icon.
    toggleAction.image = restaurantIsVisited[indexPath.row] ? UIImage(named: "undo") : UIImage(named: "tick")
    toggleAction.backgroundColor = UIColor(red: 0.149, green: 0.604, blue: 0.278, alpha: 1)
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [toggleAction])
    return swipeConfiguration
  }
  
  // Right swipe actions.
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
  
  // Prepare for segue.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestuarantDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        print("x")
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurantImageName = restaurantImages[indexPath.row]
      }
    }
  }
}
