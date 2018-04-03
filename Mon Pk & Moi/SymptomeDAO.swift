//
//  SymptomeDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol SymptomeDAO {
    
    // MARK: - Create function
    
    /// Function creating a Symptome in the database
    ///
    /// - Parameter libelle: String : The name of the Symptome
    /// - Returns: Return the new Symptome created
    /// - Throws: error
    func create(withLibelle libelle: String) throws -> Symptome
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Symptome'
    ///
    /// - Returns: array of 'Symptome'
    /// - Throws: error
    func getAllSymptomes() throws -> [Symptome]
    
    /// Function returning a Symptome according to a libelle
    ///
    /// - Parameter libelle: String : libelle to find
    /// - Returns: Return a Symptome if found
    /// - Throws: Return nil
    func find(withLibelle libelle: String) throws -> Symptome?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a 'Symptome'
    ///
    /// - Parameter aSymptome: 'Symptome' : the 'Symptome' updated to save
    /// - Returns: the 'Symptome' updated and saved
    func update(aSymptome: Symptome) -> Symptome
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'Symptome'
    ///
    /// - Parameter aSymptome: 'Symptome' : the 'Symptome' to delete
    func delete(aSymptome: Symptome)
    
}
