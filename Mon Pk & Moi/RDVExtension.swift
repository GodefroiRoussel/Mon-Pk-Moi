//
//  RDVExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension RDV {
    /// firstname of Person
    public var lieu : String?{
        get{
            return self.plieu
        }
        set{
            self.plieu = newValue
        }
    }
    
    public var tempsPourAllerALEvenement : Int16{
        get{
            return self.ptempsPourAllerALEvenement
        }
        set{
            self.ptempsPourAllerALEvenement = newValue
        }
    }
    
    public var duree : Int16{
        get{
            return self.pduree
        }
        set{
            self.pduree = newValue
        }
    }
    
    convenience init(withName nom: String, withDateTheorique dateTheorique: NSDate,withLieu lieu: String?, withTempsPourAllerALEvenement temps: Int16, withDuree duree: Int16, schedule_by patient : Patient, has traceur: Traceur, is_with contact: Contact){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pdateTheorique = dateTheorique
        self.pdateEffective = nil
        self.pestEffectue = false
        self.plieu = lieu
        self.ptempsPourAllerALEvenement = temps
        self.pduree = duree
        self.schedule_by = patient
        self.has = traceur
        self.is_with = contact
    }
}
