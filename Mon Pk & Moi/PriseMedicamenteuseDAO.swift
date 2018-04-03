//
//  PriseMedicamenteuseDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PriseMedicamenteuseDAO {
    
    // MARK: - Create function
    
    /// Function creating a 'PriseMedicamenteuse' in the database
    ///
    /// - Parameters:
    ///   - nom: String : Name of the prise
    ///   - dateTheorique: NSDate : Theoric date of the prise
    ///   - dose: Double : The dose that the patient should take
    ///   - patient: Patient : The patient that should take this medicine
    ///   - medicament: Medicament : The medicament to take
    ///   - ordonnance: Ordonnance : The Ordonnance that delivered the prise
    /// - Returns: Return a new 'PriseMedicamenteuse'
    /// - Throws: error
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDose dose: Double, schedule_by patient : Patient, belongs_to medicament :Medicament, linked_to ordonnance : Ordonnance) throws -> PriseMedicamenteuse
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'PriseMedicamenteuse'
    ///
    /// - Returns: array of 'PriseMedicamenteuse'
    /// - Throws: error
    func getAllPriseMedicamenteuses() throws -> [PriseMedicamenteuse]
    
    /// Function returning a Prise according to his name
    ///
    /// - Parameter nom: String : name of the prise
    /// - Returns: Return the 'PriseMedicamenteuse' if found
    /// - Throws: return nil
    func find(withName nom : String) throws -> PriseMedicamenteuse?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a 'PriseMedicamenteuse'
    ///
    /// - Parameter aPriseMedicamenteuse: 'PriseMedicamenteuse' : the 'PriseMedicamenteuse' updated to save
    /// - Returns: the 'PriseMedicamenteuse' updated and saved
    func update(aPriseMedicamenteuse: PriseMedicamenteuse) -> PriseMedicamenteuse
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'PriseMedicamenteuse'
    ///
    /// - Parameter aPriseMedicamenteuse: 'PriseMedicamenteuse' : the 'PriseMedicamenteuse' to delete
    func delete(aPriseMedicamenteuse: PriseMedicamenteuse)
}
