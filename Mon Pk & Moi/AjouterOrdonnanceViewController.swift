//
//  AjouterOrdonnanceViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 21/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterOrdonnanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var medecinField: UITextField!
    @IBOutlet weak var prochainRDVField: UITextField!
    @IBOutlet weak var prisesTable: UITableView!
    
    var medecins : [Contact] = []
    var medicaments : [Medicament] = []
    var doses : [Double] = []
    var times : [Date] = []
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var selectedMedecin : Contact? = nil
    
    var pickerView = UIPickerView()
    let pickerDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let contactDAO : ContactDAO = factory.getContactDAO()
        do {
            let contacts: [Contact] = try contactDAO.getAllMedecins()
            for contact in contacts {
                medecins.append(contact)
            }
        } catch let error as NSError {
                print("error")
        }

        
        createDatePicker()
        
        pickerView.delegate = self
        
        medecinField.inputView = pickerView
        medecinField.textAlignment = .center
        medecinField.placeholder = "Choisir un médecin"
        
        prochainRDVField.textAlignment = .center
        prochainRDVField.placeholder = "Choisir la date du prochain RDV"

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
        medecinField.text = selectedMedecin!.nom
        medecinField.resignFirstResponder()
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        prochainRDVField.inputAccessoryView = toolbar
        prochainRDVField.inputView = pickerDate
        
        pickerDate.datePickerMode = .date
        pickerDate.locale = Locale(identifier: "FR-fr")
        
    }
    
    func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let dateString = dateFormatter.string(from: pickerDate.date)
        
        prochainRDVField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "HH:mm"
        
        let cell = self.prisesTable.dequeueReusableCell(withIdentifier: "PriseMedicamentCell", for: indexPath)
            as! PriseOrdonnanceTableViewCell
        cell.nomMedicamentLabel.text = self.medicaments[indexPath.row].nom
        cell.doseLabel.text = "\(doses[indexPath.row])"
        cell.heureLabel.text = dateFormatter.string(from:times[indexPath.row])
        
        
        return cell
    }
    
    @IBAction func unwindToPriseListAfterSavingNewPrise(segue: UIStoryboardSegue){
        let ajouterPriseController = segue.source as! AjouterPriseViewController
        let medicament = ajouterPriseController.selectedMedicament
        let dose = ajouterPriseController.selectedDose
        let time = ajouterPriseController.heurePickerView.date
        
        self.medicaments.append(medicament!)
        self.doses.append(dose!)
        self.times.append(time)
        self.prisesTable.reloadData()
    }
    
    @IBAction func ajouterOrdonnance(_ sender: Any) {
        guard let _ = medecinField.text, !(medecinField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir un médecin.", onView: self)
            return
        }
        
        guard let _ = prochainRDVField.text, !(prochainRDVField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir la date de fin de votre traitement. Nous vous conseillons de mettre la date à dans 6 mois si cette ordonnance est délivrée par un neurologue.", onView: self)
            return
        }
        
        if (medicaments.count == 0 || doses.count == 0 || times.count == 0){
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez ajouter une prise avant d'ajouter une ordonnance.", onView: self)
            return
        }else {
            // Start the business logic
            let ordonnanceDAO: OrdonnanceDAO = factory.getOrdonnanceDAO()
            let patientDAO: PatientDAO = factory.getPatientDAO()
            let priseDAO: PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
            do {
                let patient: Patient = try patientDAO.getAllPatients()[0] //TODO : SOLUTION TEMPORAIRE A CHANGER
                let ordonnance: Ordonnance = try ordonnanceDAO.create(withDateDebutTraitement: NSDate(), concern: patient, created_by: selectedMedecin!, untillDate: pickerDate.date as NSDate)
                
                let dates = DateHelper.getDates(dateD: NSDate(), dateF: pickerDate.date as NSDate)
                for date in dates {
                    for i in 0..<medicaments.count {
                        let dateMAJ: NSDate = DateHelper.changeHour(date: date, heureMin: times[i] as NSDate)
                        let _ :PriseMedicamenteuse = try priseDAO.create(withName: "Prise Médicamenteuse", withDateTheorique: dateMAJ, withDose: doses[i], schedule_by: patient, belongs_to: medicaments[i], linked_to: ordonnance)
                    }
                }
            } catch let error as NSError {
                DialogBoxHelper.alert(onError: error, onView: self)
                return
            }

            
            
            // Envoie vers la page pilulier voir car on envoie pas forcément les informations donc peut-être juste une autre fonction
            self.performSegue(withIdentifier: "pilulier", sender: self)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination
    }
    */

}
