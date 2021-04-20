//
//  ViewController.swift
//  region-logger
//
//  Created by Alvin Tu on 4/20/21.
//

import UIKit
import MapKit

class ViewController: UIViewController {
  let mapView = MKMapView()
  let locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    locationManager.delegate = self
    
    mapView.frame = view.bounds
    view.addSubview(mapView)
    
    locationManager.requestAlwaysAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    DataManager.saveCoreData(latitudeVal: 10, longitudeVal: 10)
//    DataManager.saveCoreData(latitudeVal: 1, longitudeVal: 10)
//    DataManager.saveCoreData(latitudeVal: 3, longitudeVal: 10)
//    let thresholds = DataManager.fetchCoreData()
//    print(thresholds)
  }
}
  
  extension ViewController: MKMapViewDelegate {
    //add relevant methods
  }

extension ViewController: CLLocationManagerDelegate {
  //add relevant methods
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("hello")
  }
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("bye")
  }
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    print("authorized")
  }
  
}
  



