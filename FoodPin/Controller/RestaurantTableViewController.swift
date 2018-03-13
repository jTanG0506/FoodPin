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
  var restaurants: [RestaurantMO] = []
  
  @IBOutlet var emptyRestaurantView: UIView!
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.cellLayoutMarginsFollowReadableWidth = true
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.hidesBarsOnSwipe = true
    
    // Configure navigation bar appearance
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    
    // Change font and colour of the large title.
    if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
      navigationController?.navigationBar.largeTitleTextAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
        NSAttributedStringKey.font: customFont
      ]
    }
    
    // Prepare the empty view
    tableView.backgroundView = emptyRestaurantView
    tableView.backgroundView?.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = true
  }
  
  // MARK: - UITableViewDataSource Protocol
  override func numberOfSections(in tableView: UITableView) -> Int {
    if restaurants.count > 0 {
      tableView.backgroundView?.isHidden = true
      tableView.separatorStyle = .singleLine
    } else {
      tableView.backgroundView?.isHidden = false
      tableView.separatorStyle = .none
    }
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurants.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    cell.nameLabel.text = restaurants[indexPath.row].name
    if let restaurantImage = restaurants[indexPath.row].image {
      cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
    }
    cell.typeLabel.text = restaurants[indexPath.row].type
    cell.locationLabel.text = restaurants[indexPath.row].location
    cell.heartImageView.isHidden = !restaurants[indexPath.row].isVisited
    
    cell.selectionStyle = .none
    
    return cell
  }
  
  // MARK: - UITableViewDelegate Protocol
  // Left swipe actions.
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
    toggleAction.backgroundColor = UIColor(red: 39, green: 174, blue: 96)
    
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [toggleAction])
    return swipeConfiguration
  }
  
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
      
      let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
      let activityController: UIActivityViewController
      
      if let restaurantImage = self.restaurants[indexPath.row].image,
        let imageToShare = UIImage(data: restaurantImage as Data) {
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
    deleteAction.backgroundColor = UIColor(red: 231, green: 76, blue: 60)
    deleteAction.image = UIImage(named: "delete")
    shareAction.backgroundColor = UIColor(red: 254, green: 149, blue: 38)
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
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
  }
}
