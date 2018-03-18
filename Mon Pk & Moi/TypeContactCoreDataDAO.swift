//
//  TypeContactCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class TypeContactCoreDataDAO: TypeContactDAO{
    
    typealias A = Int
    typealias T = TypeContact
    

    init(){
    }
    
    func create(an object: TypeContact) throws -> TypeContact{
        
        let newTypeContact = TypeContact(context: CoreDataManager.context)
        
        newTypeContact.libelle = object.libelle
        do {
            try CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
        return newTypeContact
    }
    
    //TO DO: voir quoi passer en paramètre
    func find(a: Int) throws -> TypeContact{
        return TypeContact()
    }
    
    func update(an object: TypeContact) throws -> TypeContact{
        return object
    }
    
    func delete(an object: TypeContact) throws{
        return
    }
    
    func getAllTypeContacts() throws -> [TypeContact] {
        
        
        let request: NSFetchRequest<TypeContact> = TypeContact.fetchRequest()
        do {
            let medicaments: [TypeContact] = try CoreDataManager.context.fetch(request)
            return medicaments
        } catch let error as NSError {
            throw error
        }
    }
}
