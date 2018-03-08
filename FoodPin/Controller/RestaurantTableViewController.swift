//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 06/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
  
  // MARK: - Properties
  var restaurants:[Restaurant] = [
    Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend", isVisited: false),
    Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isVisited: false),
    Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isVisited: false),
    Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isVisited: false),
    Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isVisited: false),
    Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant", isVisited: false),
    Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isVisited: false),
    Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isVisited: false),
    Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate", isVisited: false),
    Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palominoespresso", isVisited: false),
    Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isVisited: false),
    Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isVisited: false),
    Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats", isVisited: false),
    Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf", isVisited: false),
    Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isVisited: false),
    Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isVisited: false),
    Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isVisited: false),
    Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isVisited: false),
    Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isVisited: false),
    Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isVisited: false),
    Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "caskpubkitchen", isVisited: false)
  ]
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.cellLayoutMarginsFollowReadableWidth = true
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: - UITableViewDataSource Protocol
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurants.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurants[indexPath.row].name
    cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
    cell.typeLabel.text = restaurants[indexPath.row].type
    cell.locationLabel.text = restaurants[indexPath.row].location
    cell.heartImageView.isHidden = !restaurants[indexPath.row].isVisited
    
    cell.selectionStyle = .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let toggleAction = UIContextualAction(style: .normal, title: "") {
      (action, sourceView, completionHandler) in
      
      self.restaurants[indexPath.row].isVisited = !self.restaurants[indexPath.row].isVisited
      let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
      cell.heartImageView.isHidden = !self.restaurants[indexPath.row].isVisited
      
      completionHandler(true)
    }
    
    // Display the appropriate icon.
    toggleAction.image = restaurants[indexPath.row].isVisited ? UIImage(named: "undo") : UIImage(named: "tick")
    toggleAction.backgroundColor = UIColor(red: 0.149, green: 0.604, blue: 0.278, alpha: 1)
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [toggleAction])
    return swipeConfiguration
  }
  
  // MARK: - UITableViewDelegate Protocol
  // Right swipe actions.
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let deleteAction = UIContextualAction(style: .destructive, title: "") {
      (action, sourceView, completionHandler) in
      
      self.restaurants.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      
      completionHandler(true)
    }
    
    let shareAction = UIContextualAction(style: .normal, title: "") {
      (action, sourceView, completionHandler) in
      
      let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
      let activityController: UIActivityViewController
      
      if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
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
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestuarantDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurant = restaurants[indexPath.row]
      }
    }
  }
}
