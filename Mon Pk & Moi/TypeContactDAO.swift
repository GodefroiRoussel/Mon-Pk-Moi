//
//  TypeContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TypeContactDAO {
    
    // MARK: - Create function
    
    /// Function creating a new TypeContact in the database
    ///
    /// - Parameter libelle: String : the libelle of the TypeAvis
    /// - Returns: Return the new TypeContact
    /// - Throws: error
    func create(withLibelle libelle: String) throws -> TypeContact?
    
    
    // MARK: - Getter functions
    
    
    /// Function returning all 'TypeContact'
    ///
    /// - Returns: array of 'TypeContact'
    /// - Throws: error
    func getAllTypeContacts() throws -> [TypeContact]
    
    /// Function returning a TypeAContact according to its libelle
    ///
    /// - Parameter libelle: String : the libelle to find
    /// - Returns: Return the TypeContact found
    /// - Throws: Return nil
    func find(withLibelle libelle: String) throws -> TypeContact?
}
