//
//  OrdonnanceExtension.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Ordonnance {
    /// firstname of Person
    public var commentaire : String?{
        get{
            return self.pcommentaire
        }
        set{
            self.pcommentaire = newValue
        }
    }
    
    /// lastname of Person
    public var dateCreation  : NSDate{
        get{
            return self.pdateCreation!
        }
    }
    
    //TODO
    func voirCollectionMedicamentNonPris(withOrdonnance ordonnance: Ordonnance) -> [PriseMedicamenteuse] {
        return [PriseMedicamenteuse()]
    }
    
    //TODO : Gérer ici la création des prises médicamenteuses.
    convenience init(withCommentaire commentaire: String, concern patient: Patient, created_by contact: Contact, untill rdv : RDV){
        self.init(context: CoreDataManager.context)
        self.pcommentaire = commentaire
        self.pdateCreation = Date() as NSDate
        self.concern = patient
        self.created_by = contact
        self.untill = rdv
    }
}
