//
//  OrdonnanceCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class OrdonnanceCoreDataDAO : OrdonnanceDAO {
    
    let request : NSFetchRequest<Ordonnance> = Ordonnance.fetchRequest()
    
    init(){
    }
    
    func getAllOrdonnances() throws -> [Ordonnance]{
        do {
            let ordonnances: [Ordonnance] = try CoreDataManager.context.fetch(self.request)
            return ordonnances
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withDateDebutTraitement dateDebut: NSDate, concern patient: Patient, created_by contact: Contact, untillDate dateFin: NSDate) throws -> Ordonnance {
        let newOrdonnance = Ordonnance(withDateDebutTraitement: dateDebut, concern: patient, created_by:  contact, untillDate: dateFin)
        CoreDataManager.save()
        return newOrdonnance
    }
    
    //A vérifier
    func find(atDate dateCreation: NSDate) throws -> Ordonnance? {
        self.request.predicate = NSPredicate(format: "pdateCreation == %@", dateCreation)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Ordonnance]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    //TODO
    func update(anOrdonnance ordonnance: Ordonnance) throws -> Ordonnance {
         CoreDataManager.save()
        return ordonnance
    }
    
    func delete(anOrdonnance ordonnance: Ordonnance) throws {
        CoreDataManager.context.delete(ordonnance)
        CoreDataManager.save()
    }
}
