//
//  ActiviteDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ActiviteDAO: EvenementDAO {
    
    func getAllActivites() throws -> [Activite]
    
    func create(an object: Activite) throws -> Activite
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Activite
    
    func update(an object: Activite) throws -> Activite
    
    func delete(an object: Activite) throws
}
