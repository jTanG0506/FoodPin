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
  
  // MARK: - View controller life cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configure(location: String) {
    // Get location
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(location, completionHandler: { (placemarks, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if let placemarks = placemarks {
        // Get the first placemark
        let placemark = placemarks[0]
        
        // Add annotation
        let annotation = MKPointAnnotation()
        
        if let location = placemark.location {
          // Display the annotation
          annotation.coordinate = location.coordinate
          self.mapView.addAnnotation(annotation)
          
          // Set the zoom level
          let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
          self.mapView.setRegion(region, animated: false)
        }
      }
    })
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
