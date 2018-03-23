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
    
    let request : NSFetchRequest<Contact> = Contact.fetchRequest()
    
    init(){
    }
    
    func getAllContacts() throws -> [Contact]{
        do {
            let contacts: [Contact] = try CoreDataManager.context.fetch(self.request)
            return contacts
        } catch let error as NSError {
            throw error
        }
    }
    
    func create(withName nom: String, withPrenom prenom: String?, withTelephone telephone: String?, withAdresse adresse: String?, is_a typeContact: TypeContact, is_connected_to patient: Patient ) throws -> Contact {
        let newContact = Contact(withName: nom, withPrenom: prenom, withTelephone: telephone, withAdresse: adresse, is_a: typeContact)
        CoreDataManager.save()
        return newContact
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
    
    func update(an object: Contact) throws -> Contact {
        return Contact(context: CoreDataManager.context)
    }
    
    func delete(aContact contact: Contact) throws {
        CoreDataManager.context.delete(contact)
        CoreDataManager.save()
    }
}
