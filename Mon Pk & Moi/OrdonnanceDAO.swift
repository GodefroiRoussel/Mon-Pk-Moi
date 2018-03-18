//
//  OrdonnanceDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol OrdonnanceDAO: AbstractDAO {
    
    func getAllOrdonnances() throws -> [Ordonnance]
    
    func getMedicamentsNonPris(ordonnance : Ordonnance) -> [PriseMedicamenteuse?]
    
    func create(an object: Ordonnance) throws -> Ordonnance
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Ordonnance
    
    func update(an object: Ordonnance) throws -> Ordonnance
    
    func delete(an object: Ordonnance) throws
}
