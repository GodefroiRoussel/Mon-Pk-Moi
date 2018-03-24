//
//  ActiviteDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ActiviteDAO {
    
    func getAllActivites() throws -> [Activite]
    
    func create(an object: Activite) throws -> Activite
    
    func find(withName nom: String) throws -> Activite
    
    func update(an object: Activite) throws -> Activite
    
    func delete(an object: Activite) throws
}
