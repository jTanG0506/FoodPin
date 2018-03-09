//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 08/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Properties
  var restaurant: Restaurant = Restaurant()
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var headerView: RestaurantDetailHeaderView!
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.largeTitleDisplayMode = .never
    tableView.separatorStyle = .none
    
    // Set tableView delegate and data source
    tableView.delegate = self
    tableView.dataSource = self
    
    // Configure header view
    headerView.nameLabel.text = restaurant.name
    headerView.typeLabel.text = restaurant.type
    headerView.headerImageView.image = UIImage(named: restaurant.image)
    headerView.heartImageView.isHidden = !restaurant.isVisited
  }
  
  // MARK: - UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self),
                                               for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "phone")
      cell.shortTextLabel.text = restaurant.phone
      
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self),
                                               for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "map")
      cell.shortTextLabel.text = restaurant.location
      
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self),
                                               for: indexPath) as! RestaurantDetailTextCell
      cell.descriptionLabel.text = restaurant.description
      
      return cell
    default:
      fatalError("Failed to instantiate the table view cell for detail view controller")
    }
  }
  
}
