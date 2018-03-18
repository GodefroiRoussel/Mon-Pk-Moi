//
//  PriseMedicamenteuseDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PriseMedicamenteuseDAO: EvenementDAO {
    
    func getAllPriseMedicamenteuses() throws -> [PriseMedicamenteuse]
    
    func create(an object: PriseMedicamenteuse) throws -> PriseMedicamenteuse
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> PriseMedicamenteuse
    
    func update(an object: PriseMedicamenteuse) throws -> PriseMedicamenteuse
    
    func delete(an object: PriseMedicamenteuse) throws
}
