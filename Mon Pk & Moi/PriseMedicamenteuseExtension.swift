//
//  PriseMedicamenteuseExtension.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension PriseMedicamenteuse {
    /// firstname of Person
    public var dose : Double{
        get{
            return self.pdose
        }
    }
    
    convenience init(withName nom: String, withDateTheorique dateTheorique: NSDate, withDose dose: Double, schedule_by patient : Patient, belongs_to medicament :Medicament, linked_to ordonnance : Ordonnance){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pdateTheorique = dateTheorique
        self.pdateEffective = nil
        self.pestEffectue = false // A vérifier mais je préfère mettre nil
        self.schedule_by = patient
        self.belongs_to = medicament
        self.linked_to = ordonnance
    }
}
