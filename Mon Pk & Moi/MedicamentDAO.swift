//
//  MedicamentDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol MedicamentDAO {
    
    // MARK: - Create function
    
    /// Function creating a medicament with a name and multiple dose
    ///
    /// - Parameters:
    ///   - withName: String : the name of the medicament
    ///   - withDoses: [Double] : array of double, that represents doses for this medicament
    /// - Returns: the new medicament created
    /// - Throws: error
    func create(withName : String, withDoses : [Double]) throws -> Medicament
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Medicament'
    ///
    /// - Returns: array of 'Medicament'
    /// - Throws: error
    func getAllMedicaments() throws -> [Medicament]
    
    /// Function returning a medicament according to his name
    ///
    /// - Parameter nom: String : the name of the medicament to find
    /// - Returns: A medicament if found else nil
    /// - Throws: nil
    func find(withName nom: String) throws -> Medicament?
    
    // MARK: - Update function
    
    /// Function updating in the database a 'Medicament'
    ///
    /// - Parameter aMedicament: 'Medicament' : the 'Medicament' updated to save
    /// - Returns: the 'Medicament' updated and saved
    func update(aMedicament: Medicament) -> Medicament

    
    // MARK: - Delete function
    
    /// Function deleting a 'Medicament'
    ///
    /// - Parameter aMedicament: 'Medicament' : the 'Medicament' to delete
    func delete(aMedicament medicament: Medicament)
}
