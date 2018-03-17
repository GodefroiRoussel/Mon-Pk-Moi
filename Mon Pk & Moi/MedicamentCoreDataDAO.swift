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
    
    /// initialize a `MedicamentModel`
    ///
    /// - Parameters:
    ///   - nom: `String` c'est le nom du `Medicament`
    ///   - doses:  `[Float]` représente les différentes doses applicables à ce médicament.
    init(){
    }
    
    func create(an object: Medicament) -> Medicament{
        return object
    }
    
    //TO DO: voir quoi passer en paramètre
    func find(a: Int) -> Medicament{
        return Medicament()
    }
    
    func update(an object: Medicament) -> Medicament{
        return object
    }
    
    func delete(an object: Medicament){
        return
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
