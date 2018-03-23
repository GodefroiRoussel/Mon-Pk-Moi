//
//  File.swift
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
    
    let request : NSFetchRequest<Medicament> = Medicament.fetchRequest()
    
    init(){
    }
    
    func create(withName nom: String, withDoses doses: [Any] ) throws -> Medicament{
        let newMedicament = Medicament(withName: nom, withDoses : doses)
        CoreDataManager.save()
        return newMedicament
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
    
    func delete( aMedicament medicament: Medicament) throws{
        CoreDataManager.context.delete(medicament)
        CoreDataManager.save()
    }
    
    func getAllMedicaments() throws -> [Medicament] {
        
        do {
            let medicaments: [Medicament] = try CoreDataManager.context.fetch(self.request)
            return medicaments
        } catch let error as NSError {
            throw error
        }
    }
}
