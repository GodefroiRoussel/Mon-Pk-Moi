//
//  AvisDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol AvisDAO {
    
    // MARK: - Create function
    
    /// Function creating an 'Avis' in the database
    ///
    /// - Parameters:
    ///   - choix: Bool : it's the choice of the physicist according to a 'TypeAvis'
    ///   - commentaire: String? : commentaire about the choice of the physicist
    ///   - traceur: Traceur : the avis is linked to a 'Traceur'
    ///   - typeAvis: TypeAvis : the avis is linked to a 'TypeAvis'
    /// - Returns: the avis created
    /// - Throws: error
    func create(withChoix choix: Bool, withCommentaire commentaire: String?, belongs_to traceur: Traceur, is_a typeAvis: TypeAvis) throws -> Avis
    
    
    // MARK: - Getter function
    
    /// Function returning all 'Avis' from the database
    ///
    /// - Returns: array of 'Avis'
    /// - Throws: error
    func getAllAvis() throws -> [Avis]
    
    
    // MARK: - Update function
    
    /// Function updating in the database an 'Avis'
    ///
    /// - Parameter anAvis: 'Avis' : the 'Avis' updated to save
    /// - Returns: the 'Avis' updated and saved
    func update(anAvis avis: Avis) -> Avis
    
    
    // MARK: - Delete function
    
    /// Function deleting an 'Avis' from the database
    ///
    /// - Parameter anAvis: 'Avis' : the 'Avis' to delete
    func delete(anAvis avis: Avis)
}
