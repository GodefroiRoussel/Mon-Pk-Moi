//
//  EvaluationExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Evaluation {
    /// firstname of Person
    public var heureDebut : NSDate{
        get{
            return self.pheureDebut!
        }
        set{
            self.pheureDebut = newValue
        }
    }
    
    public var heureFin : NSDate{
        get{
            return self.pheureFin!
        }
        set{
            self.pheureFin = newValue
        }
    }
    
    public var etat : String{
        get{
            return self.petat!
        }
        set{
            self.petat = newValue
        }
    }
    
    func ajouterSymptome(withSymptome symptome: Symptome) -> Evaluation {
        self.addToCan_have(symptome)
        return self
    }
    
    convenience init(withEtat etat: String, withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate, is_linked traceur :Traceur){
        self.init(context: CoreDataManager.context)
        self.pheureDebut = heureDebut
        self.pheureFin = heureFin
        self.petat = etat
        self.is_linked = traceur
    }
}
