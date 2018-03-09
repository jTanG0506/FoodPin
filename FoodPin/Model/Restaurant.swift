//
//  Restaurant.swift
//  FoodPin
//
//  Created by Jonathan Tang on 08/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import Foundation

class Restaurant {
  
  var name: String
  var type: String
  var location: String
  var phone: String
  var description: String
  var image: String
  var isVisited: Bool
  
  init(name: String, type: String, location: String, phone: String, description: String, image: String, isVisited: Bool) {
    self.name = name
    self.type = type
    self.location = location
    self.phone = phone
    self.description = description
    self.image = image
    self.isVisited = isVisited
  }
  
  convenience init() {
    self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isVisited: false)
  }
  
}
