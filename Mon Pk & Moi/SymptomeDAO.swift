//
//  SymptomeDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol SymptomeDAO {
    associatedtype A

    func getAllSymptomes() throws -> [Symptome]

    func create(an object: Symptome) throws -> Symptome

    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Symptome

    func update(an object: Symptome) throws -> Symptome

    func delete(an object: Symptome) throws

}
