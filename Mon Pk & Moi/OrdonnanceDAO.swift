//
//  OrdonnanceDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol OrdonnanceDAO {
    
    func getAllOrdonnances() throws -> [Ordonnance]
    
    func create(withCommentaire commentaire: String, concern patient: Patient, created_by contact: Contact, untill rdv : RDV) throws -> Ordonnance
    
    func find(atDate dateCreation: NSDate) throws -> Ordonnance?
    
    func update(anOrdonnance: Ordonnance) throws -> Ordonnance
    
    func delete(anOrdonnance: Ordonnance) throws
}
