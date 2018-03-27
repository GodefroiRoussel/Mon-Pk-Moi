//
//  SymptomeDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol SymptomeDAO {
    
    func getAllSymptomes() throws -> [Symptome]
    
    func create(withLibelle libelle: String) throws -> Symptome
    
    func find(withLibelle libelle: String) throws -> Symptome?
    
    func update(aSymptome: Symptome) throws -> Symptome
    
    func delete(aSymptome: Symptome) throws
    
}
