//
//  MonProfilViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class MonProfilViewController: UIViewController {
    
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var dateNaissanceLabel: UILabel!
    @IBOutlet weak var adresseLabel: UILabel!
    @IBOutlet weak var tempsPrepaLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let patientDAO : PatientDAO = factory.getPatientDAO()
        do {
            let patients: [Patient] = try patientDAO.getAllPatients()
            for patient in patients {
                nomLabel.text = patient.nom
                prenomLabel.text = patient.prenom
                
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let date = dateFormatter.string(from: patient.dateNaissance as Date)
                dateNaissanceLabel.text = date
                
                adresseLabel.text = patient.adresse
                tempsPrepaLabel.text = "\(patient.ptempsPreparation)"
                //medicaments.append((priseMedicamenteuse.belongs_to?.nom)!)
                //doses.append(priseMedicamenteuse.pdose)
                //dates.append(priseMedicamenteuse.pdateTheorique! as Date)
            }
            
        }catch let error as NSError {
            print("error")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
