//
//  File.swift
//  Mon Pk & Moi
//
//  Created by Godefroi Roussel on 14/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

/**
 MedicamentCoreDataDAO type
 
 **nom**: MedicamentCoreDataDAO -> String
 **doses**: MedicamentCoreDataDAO -> [Float]
 */
class MedicamentCoreDataDAO: MedicamentDAO{
    
    var nom : String
    var doses  : [Float?]
    
    /// initialize a `MedicamentModel`
    ///
    /// - Parameters:
    ///   - nom: `String` c'est le nom du `Medicament`
    ///   - doses:  `[Float]` représente les différentes doses applicables à ce médicament.
    init(nom: String, doses: [Float]){
        self.nom = nom
        self.doses  = doses
    }
    
    func ajouterDose(dose: Float) -> [Float?]{
        self.doses = self.doses + [dose]
        return self.doses
    }
}
