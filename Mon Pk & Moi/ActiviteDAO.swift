//
//  ActiviteDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol ActiviteDAO {
    
    func getAllActivites() throws -> [Activite]
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate, withDuree duree: Int16, withDescription desc: String, schedule_by patient : Patient) throws -> Activite
    
    func find(withName nom: String) throws -> Activite?
    
    func update(anActivite: Activite) throws -> Activite
    
    func delete(anActivite: Activite) throws
}
