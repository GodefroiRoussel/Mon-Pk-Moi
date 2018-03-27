//
//  MedicamentExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 22/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation


extension Medicament{
    // MARK: -
    
    /// firstname of Person
    public var nom : String{
        return self.pnom!
    }
    /// lastname of Person
    public var doses  : [Double]{
        return self.pdoses!
    }
    
    /// initialize a `Medicament`
    ///
    /// - Parameters:
    ///   - firstname: `String` first name of `Person`
    ///   - lastname:  `String` last name of `Person`
    convenience init(withName nom: String,withDoses doses: [Double]){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pdoses  = doses
    }
    
}
