//
//  Evaluation.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol EvaluationDAO {
    associatedtype A
    
    func getAllEvaluations() throws -> [Evaluation]
    
    func create(an object: Evaluation) throws -> Evaluation
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Evaluation
    
    func update(an object: Evaluation) throws -> Evaluation
    
    func delete(an object: Evaluation) throws
}
