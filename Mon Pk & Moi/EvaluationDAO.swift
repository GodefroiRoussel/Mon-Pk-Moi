//
//  EvaluationDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol EvaluationDAO {
    
    func getAllEvaluations() throws -> [Evaluation]
    
    func create(withEtat etat: String, withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate, is_linked traceur :Traceur) throws -> Evaluation
    
    func find(atHeureDebut heureDebut: NSDate) throws -> Evaluation?
    
    func update(anEvaluation evaluation: Evaluation) throws -> Evaluation
    
    func delete(anEvaluation evaluation: Evaluation) throws
}
