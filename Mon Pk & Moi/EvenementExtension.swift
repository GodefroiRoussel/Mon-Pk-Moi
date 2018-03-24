//
//  EvenementExtension.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Evenement {
    /// firstname of Person
    public var dateEffective : NSDate?{
        get{
            return self.pdateEffective
        }
        set{
            self.pdateEffective = newValue
        }
    }
    /// lastname of Person
    public var dateTheorique : NSDate{
        get{
            return self.pdateTheorique!
        }
        set{
            self.pdateTheorique = newValue
        }
    }
    
    public var estEffectue : Bool{
        get{
            return self.pestEffectue
        }
        set{
            self.pestEffectue = newValue
        }
    }
    
    func valider(anEvenement evenement: Evenement) -> Evenement {
        evenement.estEffectue = true
        return evenement
    }
    
    func refuser(anEvenement evenement: Evenement) -> Evenement {
        evenement.estEffectue = false
        return evenement
    }
    
}
