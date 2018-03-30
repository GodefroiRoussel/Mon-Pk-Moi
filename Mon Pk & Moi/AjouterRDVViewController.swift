//
//  AjouterRDVViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 30/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterRDVViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var lieuField: UITextField!
    @IBOutlet weak var dureeField: UITextField!
    @IBOutlet weak var medecinField: UITextField!
    
    var medecins : [Contact] = []
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var selectedMedecin : Contact? = nil
    
    var rdv: RDV? = nil
    var traceur: Traceur? = nil
    
    var pickerView = UIPickerView()
    let pickerDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        let contactDAO : ContactDAO = factory.getContactDAO()
        do {
            medecins = try contactDAO.getAllMedecins()
        } catch let error as NSError {
            print("error")
        }
        
        pickerView.delegate = self
        
        medecinField.inputView = pickerView

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return medecins.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return medecins[row].nom
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMedecin = medecins[row]
        medecinField.text = selectedMedecin?.nom
        medecinField.resignFirstResponder()
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

    @IBAction func ajouterRDV(_ sender: Any) {
        guard let _ = nomField.text, !(nomField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un nom pour le RDV.", onView: self)
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
        
        guard let _ = medecinField.text, !(medecinField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir un médecin.", onView: self)
            return
        }
        
        let rdvDAO: RDVDAO = factory.getRDVDAO()
        let traceurDAO: TraceurDAO = factory.getTraceurDAO()
        let patientDAO: PatientDAO = factory.getPatientDAO()
        do {
            let patient: Patient = try patientDAO.getAllPatients()[0] // TODO: Changer cette solution temporaire en faisant passer le patient dans une variable globale
            
            let date = dateField.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "FR-fr")
            let test = dateFormatter.date(from: date!)
            let test2 = Date(timeInterval: -432000, since: test!)
            let test3 = Date(timeInterval: 432000, since: test2)
            
            // TODO seulement si c'est un rendez-vous chez un Neurologue
            //traceur = try traceurDAO.create(withHeureDebut: test2 as NSDate, withHeureFin: test3 as NSDate)
            rdv = try rdvDAO.create(withName: nomField.text!, withDateTheorique: test3 as NSDate, withLieu: lieuField.text, withTempsPourAllerALEvenement: 120, withDuree: Int16(dureeField.text!)!, schedule_by: patient, is_with: selectedMedecin!)
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "agenda", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AgendaViewController
        dest.evenements.append(rdv!)
        dest.evenements.sort(by: { (element0, element1) -> Bool in
            if element0.dateTheorique as Date > element1.dateTheorique as Date {
                return false
            }
            
            return true
        })
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
