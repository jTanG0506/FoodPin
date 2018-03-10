//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by Jonathan Tang on 10/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
