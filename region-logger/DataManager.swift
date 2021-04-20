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
  
  
  static func saveCoreData(latitudeVal: Double, longitudeVal: Double) {
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
      
      let date = Date()
      
      location.setValue(latitudeVal, forKeyPath: "latitude")
      location.setValue(longitudeVal, forKeyPath: "longitude")
      location.setValue(date, forKey: "time")
    
      do {
          
          try managedContext.save()
          
      } catch let error as NSError {
          
          print("Could not save. \(error), \(error.userInfo)")
          
      }
  }
  
  static func fetchCoreData() -> [Threshold] {
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return []
    }
    let entityName = "Threshold"
    let managedContext = appDelegate.persistentContainer.viewContext


      let fetchRequest =
          NSFetchRequest<Threshold>(entityName: entityName)
    
      do {
          
          // Convert to JSON format for API call
        let thresholds = try managedContext.fetch(fetchRequest) as [Threshold]
        print(thresholds)
        clearCoreData() //clear after fetch
        return thresholds
    
          
      } catch let error as NSError {
          
          print("Could not fetch. \(error), \(error.userInfo)")
          
      }
      return []
  }


  static func clearCoreData() {
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
