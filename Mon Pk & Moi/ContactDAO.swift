//
//  ContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ContactDAO {
    func getAllContacts() throws -> [Contact]
    
    func create(withName: String, withPrenom: String?, withTelephone: String?, withAdresse: String?, is_a : TypeContact ) throws -> Contact
    
    func find(withName: String) throws -> Contact?
    
    func update(an object: Contact) throws -> Contact
    
    func delete(aContact: Contact) throws
}
