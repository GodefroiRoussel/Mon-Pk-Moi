//
//  AjouterActiviteViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 30/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterActiviteViewController: UIViewController {

    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var dureeField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var activite: Activite? = nil
    
    let pickerDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = pickerDate
        
        pickerDate.locale = Locale(identifier: "FR-fr")
        
    }
    
    func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let dateString = dateFormatter.string(from: pickerDate.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func AjouterActivite(_ sender: Any) {
        guard let _ = nomField.text, !(nomField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un nom pour l'activité.", onView: self)
            return
        }
        
        guard let _ = dateField.text, !(dateField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir une date et une heure.", onView: self)
            return
        }
        
        guard let _ = Int(dureeField.text!), !(dureeField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer une durée en minutes.", onView: self)
            return
        }
        
        guard let _ = descriptionField.text, !(descriptionField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer une description.", onView: self)
            return
        }
        
        let activiteDAO: ActiviteDAO = factory.getActiviteDAO()
        let patientDAO: PatientDAO = factory.getPatientDAO()
        do {
            let patient: Patient = try patientDAO.getAllPatients()[0] // TODO: Changer cette solution temporaire en faisant passer le patient dans une variable globale
            activite = try activiteDAO.create(withName: nomField.text!, withDateTheorique: pickerDate.date as NSDate, withDuree: Int16(dureeField.text!)!, withDescription: descriptionField.text!, schedule_by: patient)
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "agenda", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AgendaViewController
        dest.evenements.append(activite!)
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
