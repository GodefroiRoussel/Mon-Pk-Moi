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
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Ordonnance> = Ordonnance.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withDateDebutTraitement dateDebut: NSDate, concern patient: Patient, created_by contact: Contact, untillDate dateFin: NSDate) throws -> Ordonnance {
        let newOrdonnance = Ordonnance(withDateDebutTraitement: dateDebut, concern: patient, created_by:  contact, untillDate: dateFin)
        CoreDataManager.save()
        return newOrdonnance
    }
    
    // MARK: - Getter functions
    
    func getAllOrdonnances() throws -> [Ordonnance]{
        do {
            let ordonnances: [Ordonnance] = try CoreDataManager.context.fetch(self.request)
            return ordonnances
        } catch let error as NSError {
            throw error
        }
    }
    
    func voirCollectionMedicamentNonPris(withOrdonnance ordonnance: Ordonnance) -> [PriseMedicamenteuse] {
        // To obtain the beginning
        /*let numberOfDays = -5
         calculatedDate = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: numberOfDays, toDate: ordonnance.dateFin, options: NSCalendarOptions.init(rawValue: 0))
         self.request.predicate = NSPredicate(format: "date > %@", calculatedDate) // A tester
         do{
         let result = try CoreDataManager.context.fetch(request) as [PriseMedicament]
         guard result.count != 0 else { return nil }
         return result[0]
         }
         catch{
         return nil
         }
         
         let datePredicate = NSPredicate(format: "date > %@", currentDate)*/
        return []
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
    
    // MARK: - Update function
    
    func update(anOrdonnance ordonnance: Ordonnance) -> Ordonnance {
        CoreDataManager.save()
        return ordonnance
    }
    
    
    // MARK: - Delete function
    
    func delete(anOrdonnance ordonnance: Ordonnance) {
        CoreDataManager.context.delete(ordonnance)
        CoreDataManager.save()
    }
}
