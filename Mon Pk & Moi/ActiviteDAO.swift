//
//  ActiviteDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ActiviteDAO {
    // MARK: - Create function
    
    /// Function creating a new Activite in the database
    ///
    /// - Parameters:
    ///   - nom: String : the name of the 'Activite'
    ///   - dateTheorique: NSDate : the date theorique of the 'Activite'
    ///   - duree: Int16 : the time of the activity
    ///   - desc: String : description of the 'Activite'
    ///   - patient: Patient : patient linked to the 'Activite'
    /// - Returns: Activite : the activite created
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDuree duree: Int16, withDescription desc: String, schedule_by patient : Patient) -> Activite

    
    // MARK: - Getter functions
    
    /// Function returning all 'Activite' from the database
    ///
    /// - Returns: array of 'Activite'
    /// - Throws: error
    func getAllActivites() throws -> [Activite]
    
    /// Function able to find an activite according to his name
    ///
    /// - Parameter nom: String : the name of the 'Activite' to find
    /// - Returns: Activite? : the activite if found else nil
    /// - Throws: nil
    func find(withName nom: String) throws -> Activite?
    
    
    // MARK: - Update function
    
    /// Function updating in the database an 'Activite'
    ///
    /// - Parameter anActivite: 'Activite' : the 'Activite' updated to save
    /// - Returns: the 'Activite' updated and saved
    func update(anActivite: Activite) -> Activite
    
    
    // MARK: - Delete function
    
    /// Function deleting an 'Activite' from the database
    ///
    /// - Parameter anActivite: 'Activite' : the 'Activite' to delete
    func delete(anActivite: Activite)
}
