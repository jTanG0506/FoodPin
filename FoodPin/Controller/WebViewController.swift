//
//  WebViewController.swift
//  FoodPin
//
//  Created by Jonathan Tang on 20/03/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet var webView: WKWebView!
  
  var targetURL = ""
  
  // MARK: - View controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.largeTitleDisplayMode = .never
    
    if let url = URL(string: targetURL) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
  
}
