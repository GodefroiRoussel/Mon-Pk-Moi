//
//  CoreDataHelper.swift
//  Mon Pk & Moi
//
//  Created by Godefroi Roussel on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import CoreData

/**
 CoreDataManager type
 
 **
 */
class CoreDataManager: NSObject{
    
    static var context : NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            exit(EXIT_FAILURE)
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    @discardableResult
    static func save() -> NSError? {
        do {
            try CoreDataManager.context.save()
            return nil
        } catch let error as NSError {
            return error
        }
    }
    
}
