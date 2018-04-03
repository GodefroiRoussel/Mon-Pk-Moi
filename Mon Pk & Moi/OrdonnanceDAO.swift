//
//  OrdonnanceDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol OrdonnanceDAO {
    
    // MARK: - Create function
    
    /// Function creating an Ordonnance
    ///
    /// - Parameters:
    ///   - dateDebut: NSDate : the date starting the ordonnance
    ///   - patient: Patient : the patient linked to this ordonnance
    ///   - contact: Contact : the physicist who delivered the ordonnance
    ///   - dateFin: NSDate : the date ending the ordonnance
    /// - Returns: the ordonnance created
    /// - Throws: error
    func create(withDateDebutTraitement dateDebut: NSDate, concern patient: Patient, created_by contact: Contact, untillDate dateFin : NSDate) throws -> Ordonnance
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Ordonnance'
    ///
    /// - Returns: array of 'Ordonnance'
    /// - Throws: error
    func getAllOrdonnances() throws -> [Ordonnance]
    
    /// Function returning all 'Medicament' untaken during an ordonnance
    ///
    /// - Parameter ordonnance: Ordonnance : the ordonnance to check
    /// - Returns: Return an array of Prise
    func voirCollectionMedicamentNonPris(withOrdonnance ordonnance: Ordonnance) -> [PriseMedicamenteuse]

    /// Function returning the ordonannce according to his date of creation
    ///
    /// - Parameter dateCreation: NSDate : date of creation of the ordonnance to find
    /// - Returns: Return the ordonnance if found
    /// - Throws: return nil
    func find(atDate dateCreation: NSDate) throws -> Ordonnance?
    
    
    // MARK: - Update function
    
    /// Function updating in the database an 'Ordonnance'
    ///
    /// - Parameter anOrdonnance: 'Ordonnance' : the 'Ordonnance' updated to save
    /// - Returns: the 'Ordonnance' updated and saved
    func update(anOrdonnance: Ordonnance) -> Ordonnance
    
    
    // MARK: - Delete function
    
    /// Function deleting an 'Ordonnance'
    ///
    /// - Parameter anOrdonnance: 'Ordonnance' : the 'Ordonnance' to delete
    func delete(anOrdonnance: Ordonnance)

}
