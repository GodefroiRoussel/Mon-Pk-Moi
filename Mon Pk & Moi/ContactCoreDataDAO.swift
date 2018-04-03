//
//  ContactCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 23/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class ContactCoreDataDAO : ContactDAO {
    // MARK: - Properties
    
    let request : NSFetchRequest<Contact> = Contact.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withName nom: String, withPrenom prenom: String?, withTelephone telephone: String?, withAdresse adresse: String?, is_a typeContact: TypeContact, is_connected_to patient: Patient ) throws -> Contact {
        let newContact = Contact(withName: nom, withPrenom: prenom, withTelephone: telephone, withAdresse: adresse, is_a: typeContact, is_connected_to: patient)
        CoreDataManager.save()
        return newContact
    }
    
    // MARK: - Getter functions
    
    func getAllContacts() throws -> [Contact]{
        do {
            let contacts: [Contact] = try CoreDataManager.context.fetch(self.request)
            return contacts
        } catch let error as NSError {
            throw error
        }
    }
    
    func getAllMedecins() throws -> [Contact] {
        
        let typeContactDAO: TypeContactDAO = CoreDataDAOFactory.getInstance().getTypeContactDAO()
        do {
            self.request.predicate = NSPredicate(format: "%K != %@",#keyPath(Contact.is_a.plibelle) ,"Famille")
            let contacts: [Contact] = try CoreDataManager.context.fetch(self.request)
            return contacts
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(withName nom: String) throws -> Contact? {
        self.request.predicate = NSPredicate(format: "pnom == %@", nom)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Contact]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    // MARK: - Update function
    
    func update(an object: Contact) -> Contact {
        return Contact(context: CoreDataManager.context)
    }
    
    // MARK: - Delete function
    
    func delete(aContact contact: Contact) {
        CoreDataManager.context.delete(contact)
        CoreDataManager.save()
    }
}
