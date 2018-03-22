//
//  Avis.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol AvisDAO {
    
    associatedtype A
    
    func getAllAviss() throws -> [Avis]
    
    func create(an object: Avis) throws -> Avis
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Avis
    
    func update(an object: Avis) throws -> Avis
    
    func delete(an object: Avis) throws
}
