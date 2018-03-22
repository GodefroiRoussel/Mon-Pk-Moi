//
//  EvenementDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol EvenementDAO {
    associatedtype A

    func getAllEvenements() throws -> [Evenement]
    
    func create(an object: Evenement) throws -> Evenement
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> Evenement
    
    func update(an object: Evenement) throws -> Evenement
    
    func delete(an object: Evenement) throws
    
    func valider(an event : Evenement) -> Evenement
    
    func refuser(event : Evenement) -> Evenement
}
