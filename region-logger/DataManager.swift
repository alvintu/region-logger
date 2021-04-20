//
//  DataManager.swift
//  region-logger
//
//  Created by Alvin Tu on 4/20/21.
//

import Foundation
import UIKit
import CoreData

class DataManager {
  
  
  static func save(for identifier: String, state: String, latitude: Double, longitude: Double) {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let entityName = "Threshold"
    let managedContext = appDelegate.persistentContainer.viewContext


      let entity =
          NSEntityDescription.entity(forEntityName: entityName,
                                 in: managedContext)!

      let location = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
      
      
      location.setValue(latitude, forKeyPath: "latitude")
    location.setValue(longitude, forKeyPath: "longitude")
      location.setValue(state, forKeyPath: "state")
      location.setValue(Date(), forKey: "time")
          do {
          try managedContext.save()
          
      } catch let error as NSError {
          
          print("Could not save. \(error), \(error.userInfo)")
      }
  }
  
  static func fetch() -> [Threshold] {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return []
    }
    let entityName = "Threshold"
    let managedContext = appDelegate.persistentContainer.viewContext


      let fetchRequest =
          NSFetchRequest<Threshold>(entityName: entityName)
    
      do {
        let thresholds = try managedContext.fetch(fetchRequest) as [Threshold]
        print(thresholds)
        clear() //clear after fetch
        return thresholds
      } catch let error as NSError {
          
          print("Could not fetch. \(error), \(error.userInfo)")
          
      }
      return []
  }


  static func clear() {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    let entityName = "Threshold"
    let managedContext = appDelegate.persistentContainer.viewContext


      let fetchRequest =
          NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      
      let batchDeleteRequest =
          NSBatchDeleteRequest(fetchRequest: fetchRequest)
      
      do {
          try managedContext.execute(batchDeleteRequest)
          
      } catch {
          
          print("Could not delete. \(error)")
          
      }
      
  }

}
