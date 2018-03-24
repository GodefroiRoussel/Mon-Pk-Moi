//
//  RDVDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol RDVDAO: EvenementDAO {

    func getAllRDVs() throws -> [RDV]
    
    func create(an object: RDV) throws -> RDV
    
    //TO DO: voir quoi passer en paramètre
    func find(withName nom : String) throws -> RDV
    
    func update(an object: RDV) throws -> RDV
    
    func delete(an object: RDV) throws
}
