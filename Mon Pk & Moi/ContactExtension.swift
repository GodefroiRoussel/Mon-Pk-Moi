//
//  ContactExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 23/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation


extension Contact {
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
    public var prenom  : String?{
        get{
            return self.pprenom
        }
        set{
            self.pprenom = newValue
        }
    }
    
    public var telephone  : String?{
        get{
            return self.ptelephone
        }
        set{
            self.ptelephone = newValue
        }
    }
    
    public var adresse  : String?{
        get{
            return self.padresse
        }
        set{
            self.padresse = newValue
        }
    }
    
    /// initialize a `Medicament`
    ///
    /// - Parameters:
    ///   - firstname: `String` first name of `Person`
    ///   - lastname:  `String` last name of `Person`
    convenience init(withName nom: String, withPrenom prenom: String?, withTelephone telephone : String?, withAdresse adresse : String?, is_a type: TypeContact){
        self.init(context: CoreDataManager.context)
        self.pnom = nom
        self.pprenom = prenom
        self.ptelephone = telephone
        self.padresse = adresse
        self.is_a = type
    }
    
}
