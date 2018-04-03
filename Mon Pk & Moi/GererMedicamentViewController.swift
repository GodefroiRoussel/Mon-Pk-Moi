//
//  GererMedicamentViewController.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 03/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class GererMedicamentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let factory = CoreDataDAOFactory.getInstance()
    
    var medicaments: [Medicament] = []
    
    @IBOutlet weak var medicamentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let medicamentDAO: MedicamentDAO = factory.getMedicamentDAO()
        do {
            medicaments = try medicamentDAO.getAllMedicaments()
            medicaments.sort(by: { (medicament1, medicament2) -> Bool in medicament1.nom < medicament2.nom } )
        } catch {
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicaments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "medicamentCell", for: indexPath) as! MedicamentTableViewCell
        cell.nomLabel.text = self.medicaments[indexPath.row].nom
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
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
