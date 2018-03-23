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

    let request : NSFetchRequest<TypeContact> = TypeContact.fetchRequest()
    
    init(){
    }
    
    func create(withLibelle libelle: String) throws -> TypeContact?{
        
        let newTypeContact = TypeContact(context: CoreDataManager.context)
        
        newTypeContact.plibelle = libelle
        CoreDataManager.save()
        return newTypeContact
    }
    
    //TO DO: voir quoi passer en paramètre
    func find(withLibelle libelle: String) throws -> TypeContact?{
        self.request.predicate = NSPredicate(format: "plibelle == %@", libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [TypeContact]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    //TODO
    func update(aTypeContact typeContact: TypeContact) throws -> TypeContact{
        return typeContact
    }
    
    
    func getAllTypeContacts() throws -> [TypeContact] {
        do {
            let medicaments: [TypeContact] = try CoreDataManager.context.fetch(request)
            return medicaments
        } catch let error as NSError {
            throw error
        }
    }
}
