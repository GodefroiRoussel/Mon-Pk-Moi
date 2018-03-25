//
//  ActiviteCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class ActiviteCoreDataDAO: ActiviteDAO {
    
    
    let request : NSFetchRequest<Activite> = Activite.fetchRequest()
    
    init(){
    }
    
    func getAllActivites() throws -> [Activite] {
        do {
            let activites: [Activite] = try CoreDataManager.context.fetch(self.request)
            return activites
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDuree duree: Int16, withDescription desc: String, schedule_by patient : Patient) throws -> Activite {
        let newActivite = Activite(withName: nom, withDateTheorique: dateTheorique, withDuree: duree, withDescription: desc, schedule_by: patient)
            CoreDataManager.save()
            return newActivite
    }
    
    func find(withName nom: String) throws -> Activite? {
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Activite]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    func update(anActivite activite: Activite) throws -> Activite {
        CoreDataManager.save()
        return activite
    }
    
    func delete(anActivite activite: Activite) throws {
        CoreDataManager.context.delete(activite)
        CoreDataManager.save()
    }
}
