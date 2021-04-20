//
//  region_loggerTests.swift
//  region-loggerTests
//
//  Created by Alvin Tu on 4/20/21.
//

import XCTest
import MapKit
import UIKit

@testable import region_logger
class region_loggerTests: XCTestCase {
  
  var viewControllerUnderTest : ViewController!

  func testGeofenceIdentifier(){
    let viewController = ViewController()
    let coordinateA = CLLocationCoordinate2D(latitude: 40.750210, longitude:-73.874603)
    let burgerKingFence = viewController.constructGeoFence(for: coordinateA, radius: 400, identifier:"Burger_King")
    XCTAssert(burgerKingFence.radius == 400, "radius works")
  }


  func testGeofenceRadius(){
    let viewController = ViewController()
    let burgerKingString = "Burger_King"
    let coordinateA = CLLocationCoordinate2D(latitude: 40.750210, longitude:-73.874603)
    let burgerKingFence = viewController.constructGeoFence(for: coordinateA, radius: 400, identifier:"Burger_King")
    XCTAssert(burgerKingFence.identifier == burgerKingString, "identifer works")

  }
}
