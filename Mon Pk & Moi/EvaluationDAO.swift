//
//  EvaluationDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol EvaluationDAO {
    
    // MARK: - Create function
    
    /// Function creating an 'Evaluation'
    ///
    /// - Parameters:
    ///   - etat: String : etat of the patient : "ON" / "OFF" / "DYSKINESIE"
    ///   - heureDebut: NSDate : start date of the evaluation
    ///   - heureFin: NSDate : end date of the evaluation
    ///   - traceur: Traceur : this evaluation is linked to this traceur
    /// - Returns: a new traceur created with all these parameters
    /// - Throws: error
    func create(withEtat etat: String, withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate, is_linked traceur :Traceur) throws -> Evaluation
    
    
    // MARK: - Getter functions
    
    /// Function returning all 'Evaluation'
    ///
    /// - Returns: array of 'Evaluation'
    /// - Throws: error
    func getAllEvaluations() throws -> [Evaluation]
    
    /// Function returning the evaluation at this start date
    ///
    /// - Parameter heureDebut: NSDate : start date of the evaluation to find
    /// - Returns: If found return the evaluation else return nil
    func find(atHeureDebut heureDebut: NSDate) throws -> Evaluation?
    
    
    // MARK: - Update function
    
    /// Function updating in the database an 'Evaluation'
    ///
    /// - Parameter anEvaluation: 'Evaluation' : the 'Evaluation' updated to save
    /// - Returns: the 'Evaluation' updated and saved
    func update(anEvaluation evaluation: Evaluation) -> Evaluation
    
    
    // MARK: - Delete function
    
    /// Function deleting an 'Evaluation'
    ///
    /// - Parameter anEvaluation: 'Evaluation' : the 'Evaluation' to delete
    func delete(anEvaluation evaluation: Evaluation)
}
