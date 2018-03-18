//
//  TraceurDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TraceurDAO: AbstractDAO {
    func getAllTraceurs() throws -> [Traceur]
    
    func create(an object: Traceur) throws -> Traceur
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Traceur
    
    func update(an object: Traceur) throws -> Traceur
    
    func delete(an object: Traceur) throws
}
