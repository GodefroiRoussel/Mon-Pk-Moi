//
//  MedicamentCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Godefroi Roussel on 14/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

/**
 MedicamentCoreDataDAO type
 
 **nom**: MedicamentCoreDataDAO -> String
 **doses**: MedicamentCoreDataDAO -> [Float]
 */
class MedicamentCoreDataDAO: MedicamentDAO{
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withName nom: String, withDoses doses: [Double] ) throws -> Medicament{
        let newMedicament = Medicament(withName: nom, withDoses : doses)
        CoreDataManager.save()
        return newMedicament
    }
    
    // MARK: - Getter functions
    
    func getAllMedicaments() throws -> [Medicament] {
        
        do {
            let medicaments: [Medicament] = try CoreDataManager.context.fetch(self.request)
            return medicaments
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(withName nom: String) throws -> Medicament?{
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Medicament]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    // MARK: - Update function
    
    func update(aMedicament medicament: Medicament) -> Medicament {
        CoreDataManager.save()
        return medicament
    }
    
    
    // MARK: - Delete function
    
    func delete( aMedicament medicament: Medicament) {
        CoreDataManager.context.delete(medicament)
        CoreDataManager.save()
    }
}
