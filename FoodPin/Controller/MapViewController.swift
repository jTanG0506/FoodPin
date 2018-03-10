//
//  MapViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 10/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet var mapView: MKMapView!
  
  var restaurant = Restaurant()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Convert address to coordinate and annotate it on map
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(restaurant.location) { (placemarks, error) in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      if let placemarks = placemarks {
        // Get the first placemark
        let placemark = placemarks[0]
        
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.type
        
        if let location = placemark.location {
          annotation.coordinate = location.coordinate
          
          // Display the annotation
          self.mapView.showAnnotations([annotation], animated: true)
          self.mapView.selectAnnotation(annotation, animated: true)
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
