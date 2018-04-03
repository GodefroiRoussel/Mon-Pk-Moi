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
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Symptome> = Symptome.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withLibelle libelle: String) throws -> Symptome {
        let newSymptome = Symptome(withLibelle: libelle)
        CoreDataManager.save()
        return newSymptome
    }
    
    
    // MARK: - Getter functions
    
    func getAllSymptomes() throws -> [Symptome] {
        do {
            let symptomes: [Symptome] = try CoreDataManager.context.fetch(self.request)
            return symptomes
        } catch let error as NSError {
            throw error
        }
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
    
    // MARK: - Update function
    
    func update(aSymptome symptome: Symptome) -> Symptome {
        CoreDataManager.save()
        return symptome
    }
    
    // MARK: - Delete function
    
    func delete(aSymptome symptome: Symptome) {
        CoreDataManager.context.delete(symptome)
        CoreDataManager.save()
    }
}
