//
//  AvisDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol AvisDAO {
    
    func getAllAvis() throws -> [Avis]
    
    func create(withChoix choix: Bool, withCommentaire commentaire: String?, belongs_to traceur: Traceur, is_a typeAvis: TypeAvis) throws -> Avis
    
    func update(anAvis avis: Avis) throws -> Avis
    
    func delete(anAvis avis: Avis) throws
}
