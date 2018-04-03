//
//  TypeAvis.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TypeAvisDAO {
    
    // MARK: - Create function
    
    /// Function creating a new TypeAvis in the database
    ///
    /// - Parameter libelle: String : the libelle of the TypeAvis
    /// - Returns: The new TypeAvis
    /// - Throws: error
    func create(withLibelle libelle: String) throws -> TypeAvis
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'TypeAvis'
    ///
    /// - Returns: array of 'TypeAvis'
    /// - Throws: error
    func getAllTypeAvis() throws -> [TypeAvis]
    
    /// Function returning a TypeAvis according to his libelle
    ///
    /// - Parameter libelle: String : the libelle to find
    /// - Returns: Return a TypeAvis
    /// - Throws: Return nil
    func find(withLibelle libelle: String) throws -> TypeAvis?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a 'TypeAvis'
    ///
    /// - Parameter aTypeAvis: 'TypeAvis' : the 'TypeAvis' updated to save
    /// - Returns: the 'TypeAvis' updated and saved
    func update(aTypeAvis typeAvis: TypeAvis) -> TypeAvis
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'TypeAvis'
    ///
    /// - Parameter aTypeAvis: 'TypeAvis' : the 'TypeAvis' to delete
    func delete(aTypeAvis typeAvis: TypeAvis)
}
