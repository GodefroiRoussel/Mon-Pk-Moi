//
//  MedicamentDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol MedicamentDAO {
    
    func getAllMedicaments() throws -> [Medicament]
    
    func create(withName : String, withDoses : [Any]) throws -> Medicament
    
    func find(withName nom: String) throws -> Medicament?
    
    func delete(aMedicament medicament: Medicament) throws
}
