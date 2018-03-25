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
    
    
    let request : NSFetchRequest<TypeAvis> = TypeAvis.fetchRequest()
    
    init(){
    }
    
    func getAllTypeAvis() throws -> [TypeAvis] {
        do {
            let typeAvis: [TypeAvis] = try CoreDataManager.context.fetch(self.request)
            return typeAvis
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withLibelle libelle: String) throws -> TypeAvis {
        let newTypeAvis = TypeAvis(withLibelle: libelle)
        CoreDataManager.save()
        return newTypeAvis
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

    
    func update(aTypeAvis typeAvis: TypeAvis) throws -> TypeAvis {
        CoreDataManager.save()
        return typeAvis
    }
    
    func delete(aTypeAvis typeAvis: TypeAvis) throws {
        CoreDataManager.context.delete(typeAvis)
        CoreDataManager.save()
    }
}
