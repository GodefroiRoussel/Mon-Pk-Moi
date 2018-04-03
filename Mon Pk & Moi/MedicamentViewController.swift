//
//  MedicamentViewController.swift
//  Mon Pk & Moi
//
//  Created by Godefroi ROUSSEL on 03/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class MedicamentViewController: UIViewController {

    let factory = CoreDataDAOFactory.getInstance()
    
    var medicament: Medicament? = nil
    
    @IBOutlet weak var nomLabel: UILabel!
    
    @IBOutlet weak var doseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nomLabel.text = medicament!.nom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ajouterDose(_ sender: Any) {
    
    }
    
    @IBAction func modifierMedicament(_ sender: Any) {
        let medicamentDAO: MedicamentDAO = factory.getMedicamentDAO()
        let _ = medicamentDAO.update(aMedicament: medicament!)
        self.performSegue(withIdentifier: "pilulier", sender: self)
    }
    
    @IBAction func supprimerMedicament(_ sender: Any) {
        let medicamentDAO: MedicamentDAO = factory.getMedicamentDAO()
        medicamentDAO.delete(aMedicament: medicament!)
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
