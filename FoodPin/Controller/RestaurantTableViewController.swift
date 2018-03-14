//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 06/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
  
  // MARK: - Properties
  var restaurants: [RestaurantMO] = []
  var fetchResultController: NSFetchedResultsController<RestaurantMO>!
  
  @IBOutlet var emptyRestaurantView: UIView!
  
  var searchController: UISearchController!
  var searchResults: [RestaurantMO] = []
  
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
    
    // Fetch data from data store
    let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
    // Sort results in ascending order, by name.
    let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptor]
    
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      let context = appDelegate.persistentContainer.viewContext
      fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      fetchResultController.delegate = self
      
      do {
        try fetchResultController.performFetch()
        if let fetchedObjects = fetchResultController.fetchedObjects {
          restaurants = fetchedObjects
        }
      } catch {
        print(error)
      }
    }
    
    // Initialise search controller.
    searchController = UISearchController(searchResultsController: nil)
    tableView.tableHeaderView = searchController.searchBar
    
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    
    // Customise appearance of the searchController.
    searchController.searchBar.placeholder = "Search restaurants..."
    searchController.searchBar.barTintColor = .white
    searchController.searchBar.backgroundImage = UIImage()
    searchController.searchBar.tintColor = UIColor(red: 231, green: 76, blue: 60)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.hidesBarsOnSwipe = true
  }
  
  // MARK: - UISearchResultsUpdating
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      filterContent(for: searchText)
      tableView.reloadData()
    }
  }
  
  func filterContent(for searchText: String) {
    searchResults = restaurants.filter({ (restaurant) -> Bool in
      if let name = restaurant.name, let location = restaurant.location {
        let nameMatch = name.localizedCaseInsensitiveContains(searchText)
        let locationMatch = location.localizedCaseInsensitiveContains(searchText)
        return (nameMatch || locationMatch)
      }
      
      return false
    })
  }
  
  // MARK: - NSFetchedResultsControllerDelegate
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                  at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    // Handle the content change in managed object context.
    switch type {
    case .insert:
      if let newIndexPath = newIndexPath {
        tableView.insertRows(at: [newIndexPath], with: .fade)
      }
    case .delete:
      if let indexPath = indexPath {
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    case .update:
      if let indexPath = indexPath {
        tableView.reloadRows(at: [indexPath], with: .fade)
      }
    default:
      tableView.reloadData()
    }
    
    // Sync the fetched results with 'restaurants' array.
    if let fetchedObjects = controller.fetchedObjects {
      restaurants = fetchedObjects as! [RestaurantMO]
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  // MARK: - UITableViewDataSource Protocol
  override func numberOfSections(in tableView: UITableView) -> Int {
    if restaurants.count > 0 || searchController.isActive {
      tableView.backgroundView?.isHidden = true
      tableView.separatorStyle = .singleLine
    } else {
      tableView.backgroundView?.isHidden = false
      tableView.separatorStyle = .none
    }
    
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchController.isActive ? searchResults.count : restaurants.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
    
    // Determine whether the restaurant should be from search result or original array
    let restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
    
    cell.nameLabel.text = restaurant.name
    if let restaurantImage = restaurant.image {
      cell.thumbnailImageView.image = UIImage(data: restaurantImage as Data)
    }
    cell.typeLabel.text = restaurant.type
    cell.locationLabel.text = restaurant.location
    cell.heartImageView.isHidden = !restaurant.isVisited
    
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
      
      // Delete the row from the data store
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        let context = appDelegate.persistentContainer.viewContext
        let restaurantToDelete = self.fetchResultController.object(at: indexPath)
        context.delete(restaurantToDelete)
        appDelegate.saveContext()
      }
      
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
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return !searchController.isActive
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showRestuarantDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let destinationController = segue.destination as! RestaurantDetailViewController
        destinationController.restaurant = searchController.isActive ? searchResults[indexPath.row] : restaurants[indexPath.row]
      }
    }
  }
  
  @IBAction func unwindToHome(segue: UIStoryboardSegue) {
    dismiss(animated: true, completion: nil)
  }
}
