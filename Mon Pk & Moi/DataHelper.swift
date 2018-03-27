//
//  DataHelper.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

public class DataHelper {
    
    //MARK - General Functions -
    
    static func seedDataStore() {
        seedMedicament()
    }
    
    static func deleteSeeder(){
        do {
            try deleteMedicaments()
        } catch {
            
        }
    }
    
    //MARK - Medicament functions
    
    fileprivate static func seedMedicament(){
        let medicaments = MedicamentSeeder().medicaments
        
        let medicamentDAO = CoreDataDAOFactory.getInstance().getMedicamentDAO()
        
        for medicament in medicaments {
            do{
                let med = try medicamentDAO.create(withName: medicament.pnom, withDoses: medicament.pdoses)
            }catch {
                fatalError("Error cannot populate DB")
            }
        }
    }
    
    fileprivate static func deleteMedicaments() throws{
        let medicamentDAO = CoreDataDAOFactory.getInstance().getMedicamentDAO()
        do {
            let medicaments : [Medicament] = try medicamentDAO.getAllMedicaments()
            for medicament in medicaments {
                CoreDataManager.context.delete(medicament)
                print("Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    
    // MARK - TypeContact functions
    
    fileprivate static func seedTypeContact(){
        let types = TypeContactSeeder().types
        
        let typeContactDAO = CoreDataDAOFactory.getInstance().getTypeContactDAO()
        
        for libelle in types {
            do{
                try typeContactDAO.create(withLibelle: libelle)
            }catch {
                fatalError("Error cannot populate DB")
            }
        }
    }
    
}
