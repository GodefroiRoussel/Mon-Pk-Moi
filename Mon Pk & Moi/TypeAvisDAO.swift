//
//  TypeAvis.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol TypeAvisDAO {

    func getAllTypeAvis() throws -> [TypeAvis]
    
    func create(withLibelle libelle: String) throws -> TypeAvis

    func find(withLibelle libelle: String) throws -> TypeAvis?
    
    func update(aTypeAvis typeAvis: TypeAvis) throws -> TypeAvis
    
    func delete(aTypeAvis typeAvis: TypeAvis) throws
}
