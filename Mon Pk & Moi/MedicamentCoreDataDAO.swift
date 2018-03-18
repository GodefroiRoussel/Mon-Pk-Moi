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
    
    typealias A = Int
    typealias T = Medicament
    
    init(){
    }
    
    func create(an object: Medicament) throws -> Medicament{
        
            let newMedicament = Medicament(context: CoreDataManager.context)
            
            newMedicament.nom = object.nom
            newMedicament.doses = object.doses
        do {
            try CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
        return newMedicament
    }
    
    //TO DO: voir quoi passer en paramètre
    func find(a: Int) throws -> Medicament{
        return Medicament()
    }
    
    func update(an medicament: Medicament) throws -> Medicament{
        CoreDataManager.save()
        return medicament
    }
    
    func delete(an object: Medicament) throws{
        CoreDataManager.context.delete(object)
        CoreDataManager.save()
    }
    
    func getAllMedicaments() throws -> [Medicament] {
        
        
        let request: NSFetchRequest<Medicament> = Medicament.fetchRequest()
        do {
            let medicaments: [Medicament] = try CoreDataManager.context.fetch(request)
            return medicaments
        } catch let error as NSError {
            throw error
        }
    }
}
