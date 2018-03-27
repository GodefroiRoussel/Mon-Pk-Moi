//
//  SymptomeCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class SymptomeCoreDataDAO: SymptomeDAO {
    
    
    let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
    
    init(){
    }
    
    func getAllSymptomes() throws -> [Symptome] {
        do {
            let symptomes: [Symptome] = try CoreDataManager.context.fetch(self.request)
            return symptomes
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withLibelle libelle: String) throws -> Symptome {
        let newSymptome = Symptome(withLibelle: libelle)
        CoreDataManager.save()
        return newSymptome
    }
    
    func find(withLibelle libelle: String) throws -> Symptome? {
        self.request.predicate = NSPredicate(format: "plibelle == %@", libelle)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Symptome]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func update(aSymptome symptome: Symptome) throws -> Symptome {
        CoreDataManager.save()
        return symptome
    }
    
    func delete(aSymptome symptome: Symptome) throws {
        CoreDataManager.context.delete(symptome)
        CoreDataManager.save()
    }
}
