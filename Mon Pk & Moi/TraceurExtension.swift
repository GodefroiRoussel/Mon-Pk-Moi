//
//  TraceurExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Traceur {
    /// firstname of Person
    public var heureDebutJournee : NSDate{
        get{
            return self.pheureDebutJournee!
        }
        set{
            self.pheureDebutJournee = newValue
        }
    }
    
    public var heureFinJournee : NSDate{
        get{
            return self.pheureFinJournee!
        }
        set{
            self.pheureFinJournee = newValue
        }
    }
    
    convenience init(withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate){
        self.init(context: CoreDataManager.context)
        self.pheureDebutJournee = heureDebut
        self.pheureFinJournee = heureFin
    }
}
