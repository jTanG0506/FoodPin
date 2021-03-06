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
  var restaurant: RestaurantMO!
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var headerView: RestaurantDetailHeaderView!
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.hidesBarsOnSwipe = false
    navigationItem.largeTitleDisplayMode = .never
    
    // Set tableView delegate and data source
    tableView.delegate = self
    tableView.dataSource = self
    
    // Disable inset adjustment behavior to move table view upwards.
    tableView.separatorStyle = .none
    tableView.contentInsetAdjustmentBehavior = .never

    // Configure header view
    headerView.nameLabel.text = restaurant.name
    headerView.typeLabel.text = restaurant.type
    if let restaurantImage = restaurant.image {
      headerView.headerImageView.image = UIImage(data: restaurantImage as Data)
    }
    headerView.heartImageView.isHidden = !restaurant.isVisited
    if let rating = restaurant.rating {
      headerView.ratingImageView.image = UIImage(named: rating)
    }
    
    // Make the navigation bar transparent
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.tintColor = .white
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = false
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - UITableViewDataSource
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "phone")
      cell.shortTextLabel.text = restaurant.phone
      cell.selectionStyle = .none
      
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailIconTextCell.self), for: indexPath) as! RestaurantDetailIconTextCell
      cell.iconImageView.image = UIImage(named: "map")
      cell.shortTextLabel.text = restaurant.location
      cell.selectionStyle = .none
      
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
      cell.descriptionLabel.text = restaurant.summary
      cell.selectionStyle = .none
      
      return cell
    case 3:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailSeperatorCell.self), for: indexPath) as! RestaurantDetailSeperatorCell
      cell.titleLabel.text = "HOW TO GET HERE"
      cell.selectionStyle = .none
      
      return cell
    case 4:
      let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
      if let restaurantLocation = restaurant.location {
        cell.configure(location: restaurantLocation)
      }
      cell.selectionStyle = .none
      
      return cell
    default:
      fatalError("Failed to instantiate the table view cell for detail view controller")
    }
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMap" {
      let destinationController = segue.destination as! MapViewController
      destinationController.restaurant = restaurant
    } else if segue.identifier == "showReview" {
      let destinationController = segue.destination as! ReviewViewController
      destinationController.restaurant = restaurant
    }
  }
  
  @IBAction func close(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
    dismiss(animated: true) {
      if let rating = segue.identifier {
        self.restaurant.rating = rating
        self.headerView.ratingImageView.image = UIImage(named: rating)
        
        // Save update to rating
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
          appDelegate.saveContext()
        }
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        self.headerView.ratingImageView.transform = scaleTransform
        self.headerView.ratingImageView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
          self.headerView.ratingImageView.transform = .identity
          self.headerView.ratingImageView.alpha = 1
        }, completion: nil)
      }
    }
  }
}
