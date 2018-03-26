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
    
    /// lastname of Person
    public var dateDebut  : NSDate{
        get{
            return self.pdebutTraitement!
        }
    }
    
    public var dateFin  : NSDate{
        get{
            return self.pfinTraitement!
        }
    }
    
    //TODO :Gérer le passage à la ligne
    func ajouterCommentaire(withPrises prises:[PriseMedicamenteuse]) -> Ordonnance{
        // Save the information as a commentaire
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        var descriptionOrdonnance : String = ""
        for prise in prises {
            descriptionOrdonnance = descriptionOrdonnance + prise.belongs_to!.nom + String(prise.dose) + formatter.string(from: prise.dateTheorique as Date)
        }
        self.pcommentaire = descriptionOrdonnance
        return self
    }
    
    //TODO
    func voirCollectionMedicamentNonPris(withOrdonnance ordonnance: Ordonnance) -> [PriseMedicamenteuse?] {
        return [PriseMedicamenteuse()]
    }
    
    convenience init(withDateDebutTraitement dateDebut: NSDate, concern patient: Patient, created_by contact: Contact, untillDate dateFin : NSDate){
        self.init(context: CoreDataManager.context)
        self.pdateCreation = NSDate()
        self.pdebutTraitement = dateDebut
        self.concern = patient
        self.created_by = contact
        self.pfinTraitement = dateFin
    }
}

/*
 // Save the information as a commentaire and create all prisesMedicamenteuses for this ordonnance
 let formatter = DateFormatter()
 formatter.dateFormat = "HH:mm"
 for prise in prises {
 descriptionOrdonnance = descriptionOrdonnance + prise.belongs_to!.nom + String(prise.dose) + formatter.string(from: prise.dateTheorique as Date)
 //We get all the days between two dates
 let jours = DateHelper.getDates(dateD: dateDebut, dateF: rdv.dateTheorique)
 for jour in jours {
 priseMedicamenteuseDAO.create(withName: "Prise de Médicament", withDateTheorique: jour, withDose: prise.dose, schedule_by: patient, belongs_to: prise.belongs_to!, linked_to: self)
 }
 }
 self.pcommentaire = descriptionOrdonnance
 */
