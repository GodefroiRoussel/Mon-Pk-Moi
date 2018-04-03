//
//  PatientDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PatientDAO {
    
    // MARK: - Create function
    
    /// Function creating a 'Patient' with a first name, a last name, a birthday, an adress and a preparation time
    ///
    /// - Parameters:
    ///   - nom: String : last name
    ///   - prenom: String : first name
    ///   - dateNaissance: NSDate : birthday
    ///   - adresse: String : the adress of the patient
    ///   - tempsPreparation: Int16 : The time needed for the patient to prepare himself
    /// - Returns: Return the patient created
    /// - Throws: error
    func create(withName nom: String, withPrenom prenom: String, withDateNaissance dateNaissance: NSDate, withAdresse adresse : String, withTempsPreparation tempsPreparation : Int16) throws -> Patient
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Patient'
    ///
    /// - Returns: array of 'Patient'
    /// - Throws: error
    func getAllPatients() throws -> [Patient]
    
    /// Function returning the patient according to a name
    ///
    /// - Parameter withName: String : the last name of the patient
    /// - Returns: Return a patient if found
    /// - Throws: Return nil
    func find(withName: String) throws -> Patient?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a 'Patient'
    ///
    /// - Parameter aPatient: 'Patient' : the 'Patient' updated to save
    /// - Returns: the 'Patient' updated and saved
    func update(an object: Patient) -> Patient
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'Patient'
    ///
    /// - Parameter aPatient: 'Patient' : the 'Patient' to delete
    func delete(aPatient: Patient)
}
