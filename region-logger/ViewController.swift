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
  }

  func setupGeofencing(){
    let coordinateA = CLLocationCoordinate2D(latitude: 40.750210, longitude:-73.874603)
    let geofenceA = constructGeoFence(for: coordinateA, radius: 400, identifier:"Burger_King")
    
    let coordinateB = CLLocationCoordinate2D(latitude: 40.740210, longitude:-73.872603)
    let geofenceB = constructGeoFence(for: coordinateB, radius: 400, identifier:"Queens_Center")

    mapView.showsUserLocation = true
    
    if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
        self.locationManager.startMonitoring(for: geofenceA)
    }
    if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
        self.locationManager.startMonitoring(for: geofenceB)
    }
    
  }
  
  private func constructGeoFence(for center: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String ) -> CLCircularRegion{
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let mapRegion = MKCoordinateRegion(center: center, span: span)
    let regionCircle = MKCircle(center: center, radius: radius)
    let geofenceRegion = CLCircularRegion(center: center, radius: radius, identifier: identifier)
    geofenceRegion.notifyOnExit = true
    geofenceRegion.notifyOnEntry = true
    mapView.setRegion(mapRegion, animated: true)
    mapView.addOverlay(regionCircle)
    return geofenceRegion
  
  }
  
}

  extension ViewController: MKMapViewDelegate {
    //add relevant methods
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      
      let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
      overlayRenderer.lineWidth = 4.0
      overlayRenderer.strokeColor = UIColor.randomColor()
      overlayRenderer.fillColor = UIColor.randomColor()
      
      return overlayRenderer
    }

  }

extension ViewController: CLLocationManagerDelegate {
  //add relevant methods
  func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    print("entered \(region.identifier)")
    let latitude = manager.location?.coordinate.latitude ?? 0.0
    let longitude = manager.location?.coordinate.longitude ?? 0.0

    DataManager.save(for: region.identifier, state: "enter", latitude: latitude, longitude: longitude)
  }
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("exited \(region.identifier)")
    let latitude = manager.location?.coordinate.latitude ?? 0.0
    let longitude = manager.location?.coordinate.longitude ?? 0.0

    DataManager.save(for: region.identifier, state: "exit", latitude: latitude, longitude: longitude)
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
          setupGeofencing()
        }
  }
}
  



