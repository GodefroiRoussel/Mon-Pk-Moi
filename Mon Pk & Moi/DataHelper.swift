//
//  DataHelper.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

public class DataHelper {
    
    static func seedDataStore() {
        seedMedicament()
    }
    
    fileprivate static func seedMedicament(){
        let medicaments = MedicamentSeeder().medicaments
        
        let medicamentDAO = CoreDataDAOFactory.getInstance().getMedicamentDAO()
        
        for medicament in medicaments {
            let newMedicament: Medicament = Medicament()
            newMedicament.nom = medicament.nom
            newMedicament.doses = medicament.doses
            do{
                try medicamentDAO.create(an: newMedicament)
            }catch {
                fatalError("Error cannot populate DB")
            }
        }
    }
    
    fileprivate static func seedTypeContact(){
        let types = TypeContactSeeder().types
        
        let typeContactDAO = CoreDataDAOFactory.getInstance().getTypeContactDAO()
        
        for type in types {
            let newType: TypeContact = TypeContact()
            newType.libelle = type
            do{
                try typeContactDAO.create(an: newType)
            }catch {
                fatalError("Error cannot populate DB")
            }
        }
    }
    
    
}
