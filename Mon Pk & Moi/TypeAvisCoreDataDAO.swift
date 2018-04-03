//
//  TypeTypeAvisCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class TypeAvisCoreDataDAO: TypeAvisDAO {
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<TypeAvis> = TypeAvis.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
   
    func create(withLibelle libelle: String) throws -> TypeAvis {
        let newTypeAvis = TypeAvis(withLibelle: libelle)
        CoreDataManager.save()
        return newTypeAvis
    }
    
    
    // MARK: - Getter functions
    
    func getAllTypeAvis() throws -> [TypeAvis] {
        do {
            let typeAvis: [TypeAvis] = try CoreDataManager.context.fetch(self.request)
            return typeAvis
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(withLibelle libelle: String) throws -> TypeAvis? {
        self.request.predicate = NSPredicate(format: "plibelle == %@", libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [TypeAvis]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    // MARK: - Update function
    
    func update(aTypeAvis typeAvis: TypeAvis) -> TypeAvis {
        CoreDataManager.save()
        return typeAvis
    }
    
    // MARK: - Delete function
    
    func delete(aTypeAvis typeAvis: TypeAvis) {
        CoreDataManager.context.delete(typeAvis)
        CoreDataManager.save()
    }
}
