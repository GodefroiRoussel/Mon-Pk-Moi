//
//  TypeContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TypeContactDAO {
    
    func getAllTypeContacts() throws -> [TypeContact]
    
    func create(withLibelle libelle: String) throws -> TypeContact?
    
    func find(withLibelle libelle: String) throws -> TypeContact?
    
    //func update(aTypeContact typeContact: TypeContact) throws -> TypeContact
}
