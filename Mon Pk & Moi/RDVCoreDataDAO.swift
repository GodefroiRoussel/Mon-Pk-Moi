//
//  RDVCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class RDVCoreDataDAO: RDVDAO {
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<RDV> = RDV.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create functions
    
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, has traceur: Traceur, is_with contact: Contact) throws -> RDV {
        let newRDV = RDV(withName: nom, withDateTheorique: dateTheorique,withLieu: lieu, withTempsPourAllerALEvenement: temps, withDuree: duree, schedule_by: patient, has: traceur, is_with: contact)
        CoreDataManager.save()
        return newRDV
    }
    
    //Solution de secours sans le traceur
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, is_with contact: Contact) throws -> RDV {
        let newRDV = RDV(withName: nom, withDateTheorique: dateTheorique,withLieu: lieu, withTempsPourAllerALEvenement: temps, withDuree: duree, schedule_by: patient, is_with: contact)
        CoreDataManager.save()
        return newRDV
    }
    
    
    // MARK: - Getter functions
    
    func getAllRDVs() throws -> [RDV] {
        do {
            let rdvs: [RDV] = try CoreDataManager.context.fetch(self.request)
            return rdvs
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(withName nom: String) throws -> RDV? {
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [RDV]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    // MARK: - Update function
    
    func update(aRDV rdv: RDV) -> RDV {
        CoreDataManager.save()
        return rdv
    }
    
    // MARK: - Delete function
    
    func delete(aRDV rdv: RDV) {
        CoreDataManager.context.delete(rdv)
        CoreDataManager.save()
    }
}
