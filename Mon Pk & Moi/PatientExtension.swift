//
//  PatientExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Patient {
    /// firstname of Person
    public var nom : String{
        get{
            return self.pnom!
        }
        set{
            self.pnom = newValue
        }
    }
    /// lastname of Person
    public var prenom  : String{
        get{
            return self.pprenom!
        }
        set{
            self.pprenom = newValue
        }
    }
    
    public var dateNaissance  : Date{
        get{
            return self.pdateNaissance! as Date
        }
        set{
            self.pdateNaissance = newValue as NSDate
        }
    }
    
    public var adresse  : String{
        get{
            return self.padresse!
        }
        set{
            self.padresse = newValue
        }
    }
    
    public var tempsPreparation  : Int16{
        get{
            return self.ptempsPreparation
        }
        set{
            self.ptempsPreparation = newValue
        }
    }
    
    /// initialize a `Medicament`
    ///
    /// - Parameters:
    ///   - firstname: `String` first name of `Person`
    ///   - lastname:  `String` last name of `Person`
    convenience init(withName nom: String, withPrenom prenom: String, withDateNaissance dateNaissance: Date, withAdresse adresse : String, withTempsPreparation tempsPreparation : Int16){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pprenom = prenom
        self.pdateNaissance = dateNaissance as NSDate
        self.padresse = adresse
        self.ptempsPreparation = tempsPreparation
    }
    
}
