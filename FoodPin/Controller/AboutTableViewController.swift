//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 20/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {
  
  var sectionTitles = ["Feedback", "Follow Us"]
  var sectionContent = [
    [
      (image: "store", text: "Rate us on App Store", link: "https://www.apple.com/itunes/charts/paid-apps/"),
      (image: "chat", text: "Tell us your feedback", link: "http://www.appcoda.com/contact")
    ],
    [
      (image: "twitter", text: "Twitter", link: "https://twitter.com/appcodamobile"),
      (image: "facebook", text: "Facebook", link: "https://facebook.com/appcodamobile"),
      (image: "instagram", text: "Instagram", link: "https://www.instagram.com/appcodadotcom")
    ]
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.cellLayoutMarginsFollowReadableWidth = true
    navigationController?.navigationBar.prefersLargeTitles = true
    
    // Configure navigation bar appearance
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    
    if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
      navigationController?.navigationBar.largeTitleTextAttributes = [
        NSAttributedStringKey.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
        NSAttributedStringKey.font: customFont
      ]
    }
    
    // Remove excess seperators in table view.
    tableView.tableFooterView = UIView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitles.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionContent[section].count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionTitles[section]
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
    
    // Configure the cell
    let cellData = sectionContent[indexPath.section][indexPath.row]
    cell.textLabel?.text = cellData.text
    cell.imageView?.image = UIImage(named: cellData.image)
    
    return cell
  }
  
}