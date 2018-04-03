//
//  PriseMedicamenteuseCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class PriseMedicamenteuseCoreDataDAO : PriseMedicamenteuseDAO {
    // MARK: - Properties functions
    
    let request : NSFetchRequest<PriseMedicamenteuse> = PriseMedicamenteuse.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDose dose: Double, schedule_by patient : Patient, belongs_to medicament :Medicament, linked_to ordonnance : Ordonnance) throws -> PriseMedicamenteuse {
        let newPriseMedicamenteuse = PriseMedicamenteuse(withName: nom, withDateTheorique: dateTheorique, withDose: dose, schedule_by: patient, belongs_to: medicament, linked_to : ordonnance)
        CoreDataManager.save()
        return newPriseMedicamenteuse
    }
    
    
    // MARK: - Getter functions
    
    func getAllPriseMedicamenteuses() throws -> [PriseMedicamenteuse]{
        do {
            let priseMedicamenteuses: [PriseMedicamenteuse] = try CoreDataManager.context.fetch(self.request)
            return priseMedicamenteuses
        } catch let error as NSError {
            throw error
        }
    }
    
    //A vérifier
    func find(withName nom: String) throws -> PriseMedicamenteuse? {
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [PriseMedicamenteuse]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    

    // MARK: - Update function
    
    func update(aPriseMedicamenteuse priseMedicamenteuse: PriseMedicamenteuse) -> PriseMedicamenteuse {
        CoreDataManager.save()
        return priseMedicamenteuse
    }
    
    // MARK: - Delete function
    
    func delete(aPriseMedicamenteuse priseMedicamenteuse: PriseMedicamenteuse) {
        CoreDataManager.context.delete(priseMedicamenteuse)
        CoreDataManager.save()
    }
}
