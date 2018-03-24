//
//  EvenementCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class EvenementCoreDataDAO : EvenementDAO {
    
    let requestActivite : NSFetchRequest<Activite> = Activite.fetchRequest()
    let requestPrise : NSFetchRequest<PriseMedicamenteuse> = PriseMedicamenteuse.fetchRequest()
    let requestRDV : NSFetchRequest<RDV> = RDV.fetchRequest()
    
    init(){
    }

    //TODO : Add predicate patient
    func getAllEvenements() throws -> [Evenement] {
        do {
            var evenements: [Evenement]
            let activites: [Evenement] = try CoreDataManager.context.fetch(self.requestActivite)
            let prises: [Evenement] = try CoreDataManager.context.fetch(self.requestPrise)
            let RDV: [Evenement] = try CoreDataManager.context.fetch(self.requestRDV)
            evenements = activites + prises + RDV
            return evenements
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(anEvenement evenement: Evenement) throws -> Evenement{
        fatalError("You can not use this functionnality")
    }
    
    func find(withName nom: String) throws -> Activite {
        fatalError("You can not use this functionnality")
    }
    
    func update(anEvenement evenement: Evenement) throws -> Evenement{
        fatalError("You can not use this functionnality")
    }
    
    func delete(anEvenement evenement: Evenement) throws{
        fatalError("You can not use this functionnality")
    }
}
