//
//  TraceurDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TraceurDAO {
    
    func getAllTraceurs() throws -> [Traceur]
    
    func create(withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate) throws -> Traceur
    
    func update(aTraceur traceur: Traceur) throws -> Traceur
    
    func delete(aTraceur traceur: Traceur) throws
}
