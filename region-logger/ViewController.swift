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
  func setupGeofence(){
    let radius: CLLocationDistance = 400
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)

    let coordinateA = CLLocationCoordinate2D(latitude: 40.750210, longitude:-73.874603)
    let geofenceRegionCenterA = coordinateA
    let mapRegionA = MKCoordinateRegion(center: geofenceRegionCenterA, span: span)
    let regionCircle = MKCircle(center: geofenceRegionCenterA, radius: radius)
    let geofenceRegionA = CLCircularRegion(center: geofenceRegionCenterA, radius: radius, identifier: "Burger_King")
    geofenceRegionA.notifyOnExit = true
    geofenceRegionA.notifyOnEntry = true
    mapView.setRegion(mapRegionA, animated: true)
    mapView.addOverlay(regionCircle)
    mapView.showsUserLocation = true
    
    if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
        self.locationManager.startMonitoring(for: geofenceRegionA)
    }


    
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
    print("hello")
  }
  func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    print("bye")
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
          setupGeofence()
        }
  
    
  }
  
}
  



