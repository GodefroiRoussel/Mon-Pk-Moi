//
//  ContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ContactDAO: AbstractDAO {
    func getAllContacts() throws -> [Contact]
    
    func create(an object: Contact) throws -> Contact
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Contact
    
    func update(an object: Contact) throws -> Contact
    
    func delete(an object: Contact) throws
}
