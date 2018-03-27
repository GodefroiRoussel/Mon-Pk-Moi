//
//  TraceurCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class TraceurCoreDataDAO: TraceurDAO {
    
    
    let request : NSFetchRequest<Traceur> = Traceur.fetchRequest()
    
    init(){
    }
    
    func getAllTraceurs() throws -> [Traceur] {
        do {
            let traceurs: [Traceur] = try CoreDataManager.context.fetch(self.request)
            return traceurs
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate) throws -> Traceur {
        let newTraceur = Traceur(withHeureDebut: heureDebut, withHeureFin: heureFin)
        CoreDataManager.save()
        return newTraceur
    }
    
    func update(aTraceur traceur: Traceur) throws -> Traceur {
        CoreDataManager.save()
        return traceur
    }
    
    func delete(aTraceur traceur: Traceur) throws {
        CoreDataManager.context.delete(traceur)
        CoreDataManager.save()
    }
}
