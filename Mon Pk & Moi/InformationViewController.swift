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
    
    var noms : [String] = []
    var prenoms : [String] = []
    var numeros : [String] = []
    var contacts: [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let contactDAO : ContactDAO = factory.getContactDAO()
        do {
            let contacts: [Contact] = try contactDAO.getAllContacts()
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
