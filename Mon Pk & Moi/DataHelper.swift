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
        seedTypeContact()
    }
    
    static func deleteSeeder(){
        do {
            try deleteMedicaments()
            try deleteContacts()
            try deleteTypeContacts()
            try deletePatients()
            try deletePrisesMedicamenteuse()
            try deleteRDVs()
            try deleteTraceurs()
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
                print("Médicament Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    // MARK - Contact functions
    
    fileprivate static func deleteContacts() throws{
        let contactDAO = CoreDataDAOFactory.getInstance().getContactDAO()
        do {
            let contacts : [Contact] = try contactDAO.getAllContacts()
            for contact in contacts {
                CoreDataManager.context.delete(contact)
                print("Contact Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    // MARK - Patient functions
    
    fileprivate static func deletePatients() throws{
        let patientDAO = CoreDataDAOFactory.getInstance().getPatientDAO()
        do {
            let patients : [Patient] = try patientDAO.getAllPatients()
            for patient in patients {
                CoreDataManager.context.delete(patient)
                print("Patient Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    
    // MARK - Patient functions
    
    fileprivate static func deletePrisesMedicamenteuse() throws{
        let priseMedicamenteuseDAO = CoreDataDAOFactory.getInstance().getPriseMedicamenteuseDAO()
        do {
            let prises : [PriseMedicamenteuse] = try priseMedicamenteuseDAO.getAllPriseMedicamenteuses()
            for prise in prises {
                CoreDataManager.context.delete(prise)
                print("Prise Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    // MARK - RDV functions
    
    fileprivate static func deleteRDVs() throws{
        let rdvDAO = CoreDataDAOFactory.getInstance().getRDVDAO()
        do {
            let rdvs : [RDV] = try rdvDAO.getAllRDVs()
            for rdv in rdvs {
                CoreDataManager.context.delete(rdv)
                print("Rendez-vous Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
    // MARK - Traceur functions
    
    fileprivate static func deleteTraceurs() throws{
        let traceurDAO = CoreDataDAOFactory.getInstance().getTraceurDAO()
        do {
            let traceurs : [Traceur] = try traceurDAO.getAllTraceurs()
            for traceur in traceurs {
                CoreDataManager.context.delete(traceur)
                print("Traceur Supprimé")
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
    
    fileprivate static func deleteTypeContacts() throws{
        let typeContactsDAO = CoreDataDAOFactory.getInstance().getTypeContactDAO()
        do {
            let typeContacts : [TypeContact] = try typeContactsDAO.getAllTypeContacts()
            for typeContact in typeContacts {
                CoreDataManager.context.delete(typeContact)
                print("Type de contact Supprimé")
            }
            CoreDataManager.save()
        } catch let error as NSError{
            throw error
        }
    }
    
}
