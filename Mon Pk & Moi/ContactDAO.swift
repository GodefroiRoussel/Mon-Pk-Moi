//
//  ContactDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ContactDAO {
    
    // MARK: - Create function
    
    /// Function creating a new 'Contact' in the database
    ///
    /// - Parameters:
    ///   - withName: String : the last name of the contact
    ///   - withPrenom: String? : the first name of the contact
    ///   - withTelephone: String? : the phone number of the contact
    ///   - withAdresse: String : the adresse of the contact
    ///   - is_a: TypeContact : the type of this contact
    ///   - is_connected_to: Patient : the patient to be connected to
    /// - Returns: The new contact created
    /// - Throws: error
    func create(withName: String, withPrenom: String?, withTelephone: String?, withAdresse: String?, is_a : TypeContact, is_connected_to : Patient ) throws -> Contact
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Contact' from the database
    ///
    /// - Returns: array of 'Contact'
    /// - Throws: error
    func getAllContacts() throws -> [Contact]
    
    /// Function returning all physicist, that means all contacts except the type : "Contact d'urgence"
    ///
    /// - Returns: array of 'Contact'
    /// - Throws: error
    func getAllMedecins() throws -> [Contact]
    
    /// Function able to find a contact according to his name
    ///
    /// - Parameter nom: String : the name of the 'Contact' to find
    /// - Returns: Contact? : the contact if found else nil
    /// - Throws: nil
    func find(withName: String) throws -> Contact?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a'Contact'
    ///
    /// - Parameter aContact: 'Contact' : the 'Contact' updated to save
    /// - Returns: the 'Contact' updated and saved
    func update(an object: Contact) -> Contact
    
    
    // MARK: - Delete function
    
    /// Function deleting a 'Contact' from the database
    ///
    /// - Parameter aContact: 'Contact' : the 'Contact' to delete
    func delete(aContact: Contact)
}
