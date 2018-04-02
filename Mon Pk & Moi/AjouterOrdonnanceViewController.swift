//
//  AjouterOrdonnanceViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 21/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import UserNotifications

class AjouterOrdonnanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var medecinField: UITextField!
    @IBOutlet weak var prochainRDVField: UITextField!
    @IBOutlet weak var prisesTable: UITableView!
    
    var medecins : [Contact] = []
    var medicaments : [Medicament] = []
    var doses : [Double] = []
    var times : [Date] = []
    var prises : [PriseMedicamenteuse] = []
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
                var index = 1
                for date in dates {
                    for i in 0..<medicaments.count {
                        let dateMAJ: NSDate = DateHelper.changeHour(date: date, heureMin: times[i] as NSDate)
                        let prise :PriseMedicamenteuse = try priseDAO.create(withName: "Prise Médicamenteuse", withDateTheorique: dateMAJ, withDose: doses[i], schedule_by: patient, belongs_to: medicaments[i], linked_to: ordonnance)
                        prises.append(prise)
                        
                        
                        
                        //Notififcation
                        var intervaleHeure1 = prise.dateTheorique.timeIntervalSinceNow
                        intervaleHeure1 = intervaleHeure1-300
                        
                        let content = UNMutableNotificationContent()
                        content.title = prise.nom
                        
                        let dateFormatter : DateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let heure = dateFormatter.string(from: prise.dateTheorique as Date)
                        content.subtitle = heure
                        content.body = prise.belongs_to!.nom + " " + "\(prise.dose)"
                        content.badge = 1
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervaleHeure1, repeats: false)
                        let request = UNNotificationRequest(identifier: "\(prise.dateTheorique)"+"\(index)", content: content, trigger: trigger)
   
                        
                        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                        index = index+1
                    }
                }
            } catch let error as NSError {
                DialogBoxHelper.alert(onError: error, onView: self)
                return
            }

            // Envoie vers la page pilulier
            self.performSegue(withIdentifier: "pilulier", sender: self)
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let dest = segue.destination as! pilulierViewController
            for pri in prises {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                formatter.locale = Locale(identifier: "FR-fr")
                let str = formatter.string(from: pri.dateTheorique as Date)
                
                if dest.dateLabel.text == str {
                    dest.priseMedicamenteuses.append(pri)
                }
            }
            dest.priseMedicamenteuses.sort(by: { (element0, element1) -> Bool in
                if element0.dateTheorique as Date > element1.dateTheorique as Date {
                    return false
                }
                
                return true
            })
        }
    }
    

    
    // MARK: - Navigation
    
    let seguePriseViewController = "ajouterPrise"

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.seguePriseViewController {
            let dest = segue.destination as! AjouterPriseViewController
        } else {
            let dest = segue.destination as! pilulierViewController
        }
    }
    

}
