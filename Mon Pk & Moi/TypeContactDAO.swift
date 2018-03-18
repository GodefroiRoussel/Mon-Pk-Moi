//
//  TypeContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

protocol TypeContactDAO: AbstractDAO {
    func getAllTypeContacts() throws -> [TypeContact]
    
    func create(an object: TypeContact) throws -> TypeContact
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> TypeContact
    
    func update(an object: TypeContact) throws -> TypeContact
    
    func delete(an object: TypeContact) throws
}
