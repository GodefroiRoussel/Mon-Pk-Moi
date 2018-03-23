//
//  TypeContactExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 23/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension TypeContact{
    // MARK: -
    
    public var libelle : String{
        return self.plibelle!
    }

    /// initialize a `TypeContact`
    ///
    /// - Parameters:
    ///   - firstname: `String` first name of `Person`
    ///   - lastname:  `String` last name of `Person`
    convenience init(withLibelle libelle: String){
        self.init(context: CoreDataManager.context)
        self.plibelle = libelle
    }
    
}
