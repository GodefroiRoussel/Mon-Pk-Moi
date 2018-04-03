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
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Traceur> = Traceur.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate) throws -> Traceur {
        let newTraceur = Traceur(withHeureDebut: heureDebut, withHeureFin: heureFin)
        CoreDataManager.save()
        return newTraceur
    }
    
    
    // MARK: - Getter functions
    
    func getAllTraceurs() throws -> [Traceur] {
        do {
            let traceurs: [Traceur] = try CoreDataManager.context.fetch(self.request)
            return traceurs
        } catch let error as NSError {
            throw error
        }
    }
    
    func getTraceurEnCours() throws -> Traceur? {
        do {
            let traceurs: [Traceur] = try CoreDataManager.context.fetch(self.request)
            for traceur in traceurs {
                let dateRDV: NSDate = traceur.belongs_to!.dateTheorique
                //Si aujourd'hui on est dans les 5 jours avant la date de rendez-vous alors on récupère ce traceur qui est "en cours"
                if DateHelper.checkInterval(dateRDV: dateRDV, interval: 6){
                    return traceur
                }
            }
            return nil
        } catch let error as NSError {
            throw error
        }
    }
    
    
    // MARK: - Update function
    
    func update(aTraceur traceur: Traceur) -> Traceur {
        CoreDataManager.save()
        return traceur
    }
    
    // MARK: - Delete functions
    
    func delete(aTraceur traceur: Traceur) {
        CoreDataManager.context.delete(traceur)
        CoreDataManager.save()
    }
}
