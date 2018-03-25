//
//  AvisCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class AvisCoreDataDAO: AvisDAO {
    
    
    let request : NSFetchRequest<Avis> = Avis.fetchRequest()
    
    init(){
    }
    
    func getAllAvis() throws -> [Avis] {
        do {
            let avis: [Avis] = try CoreDataManager.context.fetch(self.request)
            return avis
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withChoix choix: Bool, withCommentaire commentaire: String?, belongs_to traceur: Traceur, is_a typeAvis: TypeAvis) throws -> Avis {
        let newAvis = Avis(withChoix: choix, withCommentaire: commentaire, belongs_to: traceur, is_a: typeAvis)
        CoreDataManager.save()
        return newAvis
    }

    func update(anAvis avis: Avis) throws -> Avis {
        CoreDataManager.save()
        return avis
    }
    
    func delete(anAvis avis: Avis) throws {
        CoreDataManager.context.delete(avis)
        CoreDataManager.save()
    }
}
