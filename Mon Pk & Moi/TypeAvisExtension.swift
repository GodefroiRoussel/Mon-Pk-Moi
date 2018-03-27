//
//  TypeAvis.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension TypeAvis {
    /// firstname of Person
    public var libelle : String{
        get{
            return self.plibelle!
        }
    }
    
    convenience init(withLibelle libelle: String){
        self.init(context: CoreDataManager.context)
        self.plibelle = libelle
    }
}
