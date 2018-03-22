//
//  TypeAvis.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TypeAvisDAO {
    associatedtype A
    
    func getAllTypeAviss() throws -> [TypeAvis]
    
    func create(an object: TypeAvis) throws -> TypeAvis
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> TypeAvis
    
    func update(an object: TypeAvis) throws -> TypeAvis
    
    func delete(an object: TypeAvis) throws
}
