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
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    cell.textLabel?.text = restaurantNames[indexPath.row]
    cell.imageView?.image = UIImage(named: restaurantImages[indexPath.row])
    
    return cell
  }
  
}
