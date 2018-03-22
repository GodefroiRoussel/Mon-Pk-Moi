//
//  MedicamentDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol MedicamentDAO {
    associatedtype A
    
    func getAllMedicaments() throws -> [Medicament]

    func create(withName : String, withDoses : [Any]) throws -> Medicament
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Medicament
    
    func update(an object: Medicament) throws -> Medicament
    
    func delete(an object: Medicament) throws
}
