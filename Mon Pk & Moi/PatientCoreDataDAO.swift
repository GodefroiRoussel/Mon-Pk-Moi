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
    
    let request : NSFetchRequest<Patient> = Patient.fetchRequest()
    
    init(){
    }
    
    func getAllPatients() throws -> [Patient]{
        do {
            let patients: [Patient] = try CoreDataManager.context.fetch(self.request)
            return patients
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withName nom: String, withPrenom prenom: String, withDateNaissance dateNaissance: NSDate, withAdresse adresse : String, withTempsPreparation tempsPreparation : Int16) throws -> Patient {
        let newPatient = Patient(withName: nom, withPrenom: prenom, withDateNaissance: dateNaissance, withAdresse: adresse, withTempsPreparation: tempsPreparation)
        CoreDataManager.save()
        return newPatient
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
    
    func update(an object: Patient) throws -> Patient {
        return Patient(context: CoreDataManager.context)
    }
    
    func delete(aPatient patient: Patient) throws {
        CoreDataManager.context.delete(patient)
        CoreDataManager.save()
    }
}
