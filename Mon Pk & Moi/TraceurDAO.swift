//
//  TraceurDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TraceurDAO {
    
    // MARK: - Create function
    
    
    /// Function creating a Traceur in database
    ///
    /// - Parameters:
    ///   - heureDebut: NSDate : Hour to begin the day and notifications
    ///   - heureFin: NSDate : Hour to end the day and notifications
    /// - Returns: Return a new Traceur
    /// - Throws: error
    func create(withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate) throws -> Traceur
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Traceur'
    ///
    /// - Returns: array of 'Traceur'
    /// - Throws: error
    func getAllTraceurs() throws -> [Traceur]

    /// Function returning the curent 'Traceur'. The current 'Traceur' is represented by if today is between the dateRDV for a neurologue and 6 days before (start of the traceur)
    ///
    /// - Returns: Traceur? : A traceur if exists else nil
    /// - Throws: error
    func getTraceurEnCours() throws -> Traceur?
    
    
    // MARK: - Update function
    
    /// Function updating in the database a 'Traceur'
    ///
    /// - Parameter aTraceur: 'Traceur' : the 'Traceur' updated to save
    /// - Returns: the 'Traceur' updated and saved
    func update(aTraceur traceur: Traceur) -> Traceur
    
    // MARK: - Delete function
    
    /// Function deleting a 'Traceur'
    ///
    /// - Parameter aTraceur: 'Traceur' : the 'Traceur' to delete
    func delete(aTraceur traceur: Traceur)
}
