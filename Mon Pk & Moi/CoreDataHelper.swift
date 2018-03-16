//
//  CoreDataHelper.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import CoreData

/**
 CoreDataHelper type
 
 **
 */
class CoreDataHelper: NSObject{
    
    static var context : NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Application Failed")
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    static func save() -> NSError? {
        do {
            let context = CoreDataHelper.context
            try context.save()
            return nil
        } catch let error as NSError {
            return error
        }
    }
    
}
