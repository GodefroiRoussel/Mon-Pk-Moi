//
//  PatientCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 24/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class PatientCoreDataDAO : PatientDAO {
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Patient> = Patient.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withName nom: String, withPrenom prenom: String, withDateNaissance dateNaissance: NSDate, withAdresse adresse : String, withTempsPreparation tempsPreparation : Int16) throws -> Patient {
        let newPatient = Patient(withName: nom, withPrenom: prenom, withDateNaissance: dateNaissance, withAdresse: adresse, withTempsPreparation: tempsPreparation)
        CoreDataManager.save()
        return newPatient
    }
    
    
    // MARK: - Getter functions
    
    func getAllPatients() throws -> [Patient]{
        do {
            let patients: [Patient] = try CoreDataManager.context.fetch(self.request)
            return patients
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(withName nom: String) throws -> Patient? {
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Patient]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    // MARK: - Update function
    
    func update(an object: Patient) -> Patient {
        return Patient(context: CoreDataManager.context)
    }
    
    // MARK: - Delete function
    
    func delete(aPatient patient: Patient) {
        CoreDataManager.context.delete(patient)
        CoreDataManager.save()
    }
}
