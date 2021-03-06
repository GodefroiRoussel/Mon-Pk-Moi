//
//  InformationViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactsTable: UITableView!

    var contacts: [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let contactDAO : ContactDAO = factory.getContactDAO()
        do {
            contacts = try contactDAO.getAllContacts()
        }catch let error as NSError {
            print("error")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.contactsTable.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
            as! ContactTableViewCell
        cell.nomLabel.text = self.contacts[indexPath.row].nom
        cell.prenomLabel.text = self.contacts[indexPath.row].prenom
        cell.numeroLabel.text = self.contacts[indexPath.row].telephone
        return cell
    }
    
    //fonction qui permet de supprimer un contact
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //fonction qui permet de faire le lien avec la page ajouter contact
    @IBAction func unwindToInformationAfterSavingContact(segue: UIStoryboardSegue){
        self.contactsTable.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
