//
//  RDVDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol RDVDAO {
    
    func getAllRDVs() throws -> [RDV]
    
    func create(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, has traceur: Traceur, is_with contact: Contact) throws -> RDV
    
    //TO DO: voir quoi passer en paramètre
    func find(withName nom : String) throws -> RDV?
    
    func update(aRDV rdv: RDV) throws -> RDV
    
    func delete(aRDV rdv: RDV) throws
}
