//
//  ActiviteExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Activite {
    /// firstname of Person
    public var duree : Int16{
        get{
            return self.pduree
        }
        set{
            self.pduree = newValue
        }
    }
    
    public var desc : String{
        get{
            return self.pdesc!
        }
        set{
            self.pdesc = newValue
        }
    }
    
    //TODO: change Date()
    convenience init(withName nom: String, withDateTheorique dateTheorique: NSDate, withDuree duree: Int16, withDescription desc: String, schedule_by patient : Patient){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pdateTheorique = Date() as NSDate
        self.pdateEffective = nil
        self.pestEffectue = false // A vérifier mais je préfère mettre nil
        self.pduree = duree
        self.pdesc = desc
        self.schedule_by = patient
    }
}
