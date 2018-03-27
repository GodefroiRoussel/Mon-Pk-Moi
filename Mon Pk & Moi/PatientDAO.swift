//
//  PatientDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PatientDAO {
    
    func getAllPatients() throws -> [Patient]
    
    func create(withName nom: String, withPrenom prenom: String, withDateNaissance dateNaissance: NSDate, withAdresse adresse : String, withTempsPreparation tempsPreparation : Int16) throws -> Patient
    
    func find(withName: String) throws -> Patient?
    
    func update(an object: Patient) throws -> Patient
    
    func delete(aPatient: Patient) throws
}
