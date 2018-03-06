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
 
  override func viewDidLoad() {
    super.viewDidLoad()
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
    
    cell.selectionStyle = .none
    
    return cell
  }
  
}
