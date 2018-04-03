//
//  RDVDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol RDVDAO {
    
    // MARK: - Create functions
    
    
    /// Function creating a RDV with a traceur in the database
    ///
    /// - Parameters:
    ///   - nom: String : Name of the RDV
    ///   - dateTheorique: NSDate : Theoric date of the RDV
    ///   - lieu: String : The place where the RDV is
    ///   - temps: Int16 : Time needed to go at the place
    ///   - duree: Int16 : Time for the RDV
    ///   - patient: Patient : The patient that created this RDV
    ///   - traceur: Traceur : The traceur linked to this RDV
    ///   - contact: Contact : The contact where the patient has a RDV
    /// - Returns: Return a new Traceur
    /// - Throws: nil
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, has traceur: Traceur, is_with contact: Contact) throws -> RDV
    
    /// Function creating a RDV without a traceur in the database
    ///
    /// - Parameters:
    ///   - nom: String : Name of the RDV
    ///   - dateTheorique: NSDate : Theoric date of the RDV
    ///   - lieu: String : The place where the RDV is
    ///   - temps: Int16 : Time needed to go at the place
    ///   - duree: Int16 : Time for the RDV
    ///   - patient: Patient : The patient that created this RDV
    ///   - contact: Contact : The contact where the patient has a RDV
    /// - Returns: Return a new Traceur
    /// - Throws: nil
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, is_with contact: Contact) throws -> RDV
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'RDV'
    ///
    /// - Returns: array of 'RDV'
    /// - Throws: error
    func getAllRDVs() throws -> [RDV]
    
    /// Function returning a 'RDV' according to his name
    ///
    /// - Parameter nom: String : name of the RDV to find
    /// - Returns: Return the RDV if found
    /// - Throws: Return nil
    func find(withName nom : String) throws -> RDV?
    
    
    // MARK: - Update function
    
    /// Function updating in the database an 'RDV'
    ///
    /// - Parameter anRDV: 'RDV' : the 'RDV' updated to save
    /// - Returns: the 'RDV' updated and saved
    func update(aRDV rdv: RDV) -> RDV
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'RDV'
    ///
    /// - Parameter aRDV: 'RDV' : the 'RDV' to delete
    func delete(aRDV rdv: RDV)
}
