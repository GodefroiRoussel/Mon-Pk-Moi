//
//  AjouterContactViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterContactViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var typeContactLabel: UITextField!
    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var prenomField: UITextField!
    @IBOutlet weak var numeroField: UITextField!
    @IBOutlet weak var adresseField: UITextField!
    
    var pickerView = UIPickerView()
    
    var typeContacts : [TypeContact] = []
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var selectedTypeContact : TypeContact? = nil
    
    var contact: Contact? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let typeContactDAO : TypeContactDAO = factory.getTypeContactDAO()
        do {
            let typeconts: [TypeContact] = try typeContactDAO.getAllTypeContacts()
            for typecontact in typeconts {
                typeContacts.append(typecontact)
            }
        } catch let error as NSError {
            print("error")
        }
        
        pickerView.delegate = self
        
        typeContactLabel.inputView = pickerView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeContacts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeContacts[row].libelle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTypeContact = typeContacts[row]
        typeContactLabel.text = selectedTypeContact!.libelle
        typeContactLabel.resignFirstResponder()
    }

    @IBAction func ajouterContact(_ sender: Any) {
        guard let _ = typeContactLabel.text, !(typeContactLabel.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir un type de contact.", onView: self)
            return
        }
        
        guard let _ = nomField.text, !(nomField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un nom.", onView: self)
            return
        }
        
        guard let _ = prenomField.text, !(prenomField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un prénom.", onView: self)
            return
        }
        
        guard let _ = numeroField.text, !(numeroField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un numéro de téléphone.", onView: self)
            return
        }
        
        guard let _ = adresseField.text, !(adresseField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer une adresse.", onView: self)
            return
        }
        
        //Start the business logic
        //A  revoir 
        
        let contactDAO: ContactDAO = factory.getContactDAO()
        let patientDAO: PatientDAO = factory.getPatientDAO()
        do {
            let patient: Patient = try patientDAO.getAllPatients()[0] //TODO : SOLUTION TEMPORAIRE A CHANGER
            contact = try contactDAO.create(withName: nomField.text!, withPrenom: prenomField.text, withTelephone: numeroField.text, withAdresse: adresseField.text, is_a: selectedTypeContact!, is_connected_to: patient)

        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        } 
        
        // Envoie vers la page pilulier voir car on envoie pas forcément les informations donc peut-être juste une autre fonction
        self.performSegue(withIdentifier: "informations", sender: self)
    
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! InformationViewController
        dest.contacts.append(contact!)
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
