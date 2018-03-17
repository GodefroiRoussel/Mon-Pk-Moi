//
//  MedicamentDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import CoreData

protocol MedicamentDAO: AbstractDAO {
    func getAllMedicaments() throws -> [Medicament]

    func create(an object: Medicament) -> Medicament
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) -> Medicament
    
    func update(an object: Medicament) -> Medicament
    
    func delete(an object: Medicament)
}
