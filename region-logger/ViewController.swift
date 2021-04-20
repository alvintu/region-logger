//
//  ViewController.swift
//  region-logger
//
//  Created by Alvin Tu on 4/20/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    DataManager.saveCoreData(latitudeVal: 10, longitudeVal: 10)
    DataManager.saveCoreData(latitudeVal: 1, longitudeVal: 10)
    DataManager.saveCoreData(latitudeVal: 3, longitudeVal: 10)
    let thresholds = DataManager.fetchCoreData()
    print(thresholds)
  }

  

}

