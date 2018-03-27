//
//  AppDelegate.swift
//  Mon Pk & Moi
//
//  Created by romain on 07/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]? = nil) -> Bool {
        // If it's the first launch of the application, we create the data in the database
        //UserDefaults.standard.set(false, forKey: "wasLaunched")
        if(!UserDefaults.standard.bool(forKey: "wasLaunched")){
            DataHelper.deleteSeeder()
            DataHelper.seedDataStore()
            UserDefaults.standard.set(true, forKey: "wasLaunched")
        }
        
        let factory : CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        
        //Create a type contact
        let typeContactDAO: TypeContactDAO = factory.getTypeContactDAO()
        let contactDAO : ContactDAO = factory.getContactDAO()
        let patientDAO : PatientDAO = factory.getPatientDAO()
        let priseMedicamenteuseDAO : PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        let medicamentDAO : MedicamentDAO = factory.getMedicamentDAO()
        let ordonnanceDAO : OrdonnanceDAO = factory.getOrdonnanceDAO()
        
        let date : NSDate = Date() as NSDate
        
        
        /*let dateComponents = NSDateComponents()
        dateComponents.day = 4
        dateComponents.month = 5
        dateComponents.year = 2017
        
        if let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian),
            let date = gregorianCalendar.date(from: dateComponents as DateComponents) {
            let weekday = gregorianCalendar.component(.weekday, from: date)
            print(date) // 5, which corresponds to Thursday in the Gregorian Calendar
        }
        */
        let dateFormatter = DateFormatter()
        var dateAsString = "24-12-2015 23:59"
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var newDate = dateFormatter.date(from: dateAsString)
        print(newDate)
        
        
        
        /*let dateComponents = NSDateComponents()
        let day = dateComponents.day
        let month = dateComponents.month
        print(day)
        print(month)
        */
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        //print(dateTest)
        do{
            let patient : Patient = try patientDAO.create(withName: "Thevenon", withPrenom: "Romain", withDateNaissance: date, withAdresse: "Polytech", withTempsPreparation: 90)
            print(patient)
            let typeContact : TypeContact = try typeContactDAO.create(withLibelle: "Famille")!
            print(typeContact)
            print("\n")
            print("\n")
            print("\n")
            let contact : Contact = try contactDAO.create(withName: "Roussel", withPrenom: "Godefroi", withTelephone: "0606060606", withAdresse: "Polytech", is_a: typeContact, is_connected_to : patient)
            print("J'ai créé \(contact.nom)")
            
            /*let contact : Contact = try contactDAO.create(withName: "Rouquier", withPrenom: "Clément", withTelephone: "0606060606", withAdresse: "Polytech", is_a: typeContact, is_connected_to : patient)
            
            
            let patients : [Patient] = try patientDAO.getAllPatients()
            print("On regarde tous les patients de la BD")
            for patient in patients {
                print("Patient")
                print(patient)
            }*/
            
            let typeMedecin : TypeContact = try typeContactDAO.find(withLibelle:"kinésithérapeute")!
            let contactRouquier : Contact = try contactDAO.create(withName: "Rouquier", withPrenom: "Clément", withTelephone: "0606060606", withAdresse: "Polytech", is_a: typeMedecin, is_connected_to : patient)
            
            print("J'ai créé \(contactRouquier.nom)")
            print("\n")
            print("\n")
            print("\n")
            
            print("On regarde tous les contacts de la BD")
            print("\n")
            let contacts : [Contact] = try contactDAO.getAllContacts()
            for contact in contacts {
                print("Contact : \(contact.nom)")
                print(contact.is_a!.libelle)
            }
            
            print("\n")
            print("\n")
            print("\n")
            
            let famille = try typeContactDAO.find(withLibelle: "Famille")
            print(famille!)
            print("\n")
            print("\n")
            print("\n")
            
            print("On regarde si on obtient que les médecins")
            print("\n")
            let medecins : [Contact] = try contactDAO.getAllMedecins()
            for medecin in medecins {
                print("Medecin : ")
                print(medecin)
            }
            
            print("\n")
            print("\n")
            print("\n")
            
            let dateTheorique = NSDate()
            let ordonnance: Ordonnance = try ordonnanceDAO.create(withDateDebutTraitement: NSDate(), concern: patient, created_by: contactRouquier, untillDate: NSDate())
            print(ordonnance)
            let medicament = try medicamentDAO.find(withName: "MODOPAR")
            print(medicament!)
            let prise :PriseMedicamenteuse = try priseMedicamenteuseDAO.create(withName: "Prise médicament", withDateTheorique: NSDate(), withDose: 500.0, schedule_by: patient, belongs_to: medicament!, linked_to: ordonnance)
            print(prise)
            
            print("\n")
            print("\n")
            print("\n")
            
            print("Toutes les prises")
            let prises : [PriseMedicamenteuse] = try priseMedicamenteuseDAO.getAllPriseMedicamenteuses()
            for hello in prises {
                print(hello)
            }
            
            print("\n")
            print("\n")
            print("\n")
            
            print("Toutes les prises d'aujourd'hui")
            let test : [PriseMedicamenteuse] = try priseMedicamenteuseDAO.getAllPriseMedicamenteuseForADay(forDay: newDate! as NSDate)
            for hello in prises {
                print(hello)
            }
            
            print("\n")
            print("\n")
            print("\n")
            
        } catch let error as NSError {
            print(error)
            return false
        }
        
        
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Mon_Pk___Moi")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

