//
//  PriseMedicamenteuseDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol PriseMedicamenteuseDAO {
    
    func getAllPriseMedicamenteuses() throws -> [PriseMedicamenteuse]
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDose dose: Double, schedule_by patient : Patient, belongs_to medicament :Medicament, linked_to ordonnance : Ordonnance) throws -> PriseMedicamenteuse
    
    func find(withName nom : String) throws -> PriseMedicamenteuse?
    
    func update(aPriseMedicamenteuse: PriseMedicamenteuse) throws -> PriseMedicamenteuse
    
    func delete(aPriseMedicamenteuse: PriseMedicamenteuse) throws
}
