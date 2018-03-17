//
//  MedicamentSeeder.swift
//  Mon Pk & Moi
//
//  Created by Godefroi Roussel on 17/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

public class MedicamentSeeder {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func seedDataStore() {
        seedMedicaments()
    }
    
    fileprivate func seedMedicaments() {
        let medicaments = [
            (nom: "MODOPAR", doses: [62.5,125,250]),
            (nom: "MODOPAR LP", doses: [125]),
            (nom: "MODOPAR DISPERSIBLE", doses: [125]),
            (nom: "SINEMET", doses: [100,250]),
            (nom: "SINEMET LP", doses: [100, 200]),
            (nom: "STALEVO", doses: [50,75,100,125,150,175,200]),
            (nom: "PARLODEL", doses: [2.5,5,10]),
            (nom: "TRIVASTAL", doses: [20]),
            (nom: "TRIVASTAL LP", doses: [50]),
            (nom: "SIFROL", doses: [0.18, 0.7]),
            (nom: "SIFROL LP", doses: [0.26,0.52,1.05,2.1]),
            (nom: "REQUIP", doses: [0.25,0.5,1,2,5]),
            (nom: "REQUIP LP", doses: [2,4,8]),
            (nom: "NEUPRO (PATCH)", doses: [2,4,6,8]),
            (nom: "MANTADIX", doses: [100]),
            (nom: "AZILECT", doses: [1]),
            (nom: "COMTAN", doses: [200]),
            (nom: "ARTANE", doses: [2,5]),
            (nom: "PARKINANE LP", doses: [2,5]),
            (nom: "LEPTICUR", doses: [10]),
            (nom: "LEPONEX", doses: [25,100]),
            (nom: "EXELON", doses: [1.5,3,4.5,6]),
            (nom: "EXELON (PATCH)", doses: [4.6,9.5])
            
        ]
        
        for medicament in medicaments {
            let newMedicament = Medicament(context: CoreDataManager.context)
            
            newMedicament.nom = medicament.nom
            newMedicament.doses = medicament.doses
        }
        
        CoreDataManager.save()

    }
}
