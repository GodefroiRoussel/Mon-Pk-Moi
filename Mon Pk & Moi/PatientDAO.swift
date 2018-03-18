//
//  PatientDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PatientDAO: AbstractDAO {
    func getAllPatients() throws -> [Patient]
    
    func create(an object: Patient) throws -> Patient
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Patient
    
    func update(an object: Patient) throws -> Patient
    
    func delete(an object: Patient) throws
}
