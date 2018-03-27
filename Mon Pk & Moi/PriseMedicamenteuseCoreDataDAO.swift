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
    
    let request : NSFetchRequest<PriseMedicamenteuse> = PriseMedicamenteuse.fetchRequest()
    
    init(){
    }
    
    func getAllPriseMedicamenteuses() throws -> [PriseMedicamenteuse]{
        do {
            let priseMedicamenteuses: [PriseMedicamenteuse] = try CoreDataManager.context.fetch(self.request)
            return priseMedicamenteuses
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDose dose: Double, schedule_by patient : Patient, belongs_to medicament :Medicament, linked_to ordonnance : Ordonnance) throws -> PriseMedicamenteuse {
        let newPriseMedicamenteuse = PriseMedicamenteuse(withName: nom, withDateTheorique: dateTheorique, withDose: dose, schedule_by: patient, belongs_to: medicament, linked_to : ordonnance)
        CoreDataManager.save()
        return newPriseMedicamenteuse
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
    
    //TODO
    func update(aPriseMedicamenteuse priseMedicamenteuse: PriseMedicamenteuse) throws -> PriseMedicamenteuse {
        CoreDataManager.save()
        return priseMedicamenteuse
    }
    
    func delete(aPriseMedicamenteuse priseMedicamenteuse: PriseMedicamenteuse) throws {
        CoreDataManager.context.delete(priseMedicamenteuse)
        CoreDataManager.save()
    }
    
    //TODO : vérifier le format des dates ne fonctionne pas actuellement
    func getAllPriseMedicamenteuseForADay(forDay day: NSDate) throws -> [PriseMedicamenteuse] {
        do {
            self.request.predicate = NSPredicate(format: " pdateTheorique == %@", day)
            let priseMedicamenteuses: [PriseMedicamenteuse] = try CoreDataManager.context.fetch(self.request)
            return priseMedicamenteuses
        } catch let error as NSError {
            throw error
        }
    }
}
