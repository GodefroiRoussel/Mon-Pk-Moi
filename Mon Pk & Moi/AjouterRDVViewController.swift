//
//  AjouterRDVViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 30/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import UserNotifications

class AjouterRDVViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var tempsField: UITextField!
    @IBOutlet weak var dureeField: UITextField!
    @IBOutlet weak var medecinField: UITextField!
    
    var medecins : [Contact] = []
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var selectedMedecin : Contact? = nil
    
    var rdv: RDV? = nil
    var traceur: Traceur? = nil
    var avis: Avis? = nil
    
    var pickerView = UIPickerView()
    let pickerDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        // MARK: - Recuperation allMedecins
        //Récuperation de l'ensemble des médecins
        let contactDAO : ContactDAO = factory.getContactDAO()
        do {
            medecins = try contactDAO.getAllMedecins()
            if medecins.count == 0 {
                medecinField.text = "Aucun médecin n'a encore été créé"
                medecinField.isEnabled = false
            }
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
        if medecins.count > 0{
            selectedMedecin = medecins[row]
            medecinField.text = selectedMedecin?.nom
            medecinField.resignFirstResponder()
        }
        
    }
    
    // MARK: - PickerDate
    //fonction qui permet de créer le pickerDate
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = pickerDate
        
        pickerDate.locale = Locale(identifier: "FR-fr")
        
    }
    
    // MARK: - Affiche Valeur PickerDate
    //fonction qui permet d'afficher la valeur de la date choisie dans le textField
    func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let dateString = dateFormatter.string(from: pickerDate.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    // MARK: - Revenir à l'agenda
    //Fonction qui permet de revenir à l'agenda sans aucune action si on appuye sur le bouton annuler
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - AjouterRDV
    //Fonction qui permet d'ajouter un RDV
    @IBAction func ajouterRDV(_ sender: Any) {
        guard let _ = nomField.text, !(nomField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer un nom pour le RDV.", onView: self)
            return
        }
        
        guard let _ = dateField.text, !(dateField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir une date et une heure.", onView: self)
            return
        }
        
        guard let _ = tempsField.text, !(tempsField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer le temps pour y aller en minutes.", onView: self)
            return
        }
        
        guard let _ = Int(dureeField.text!), !(dureeField.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer une durée en minutes.", onView: self)
            return
        }
        
        guard let _ = medecinField.text, selectedMedecin != nil else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir un médecin.", onView: self)
            return
        }
        
        let rdvDAO: RDVDAO = factory.getRDVDAO()
        let traceurDAO: TraceurDAO = factory.getTraceurDAO()
        let patientDAO: PatientDAO = factory.getPatientDAO()
        let avisDAO: AvisDAO = factory.getAvisDAO()
        let typeAvisDAO: TypeAvisDAO = factory.getTypeAvisDAO()
        do {
            let patient: Patient = try patientDAO.getAllPatients()[0] // TODO: Changer cette solution temporaire en faisant passer le patient dans une variable globale
            
            let date = dateField.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            dateFormatter.locale = Locale(identifier: "FR-fr")
            let test = dateFormatter.date(from: date!)
            let test2 = Date(timeInterval: -432000, since: test!)
            let test3 = Date(timeInterval: 432000, since: test2)
            
            let typeAvis: [TypeAvis] = try typeAvisDAO.getAllTypeAvis()
            
            if selectedMedecin?.is_a?.libelle == "neurologue" {
                traceur = try traceurDAO.create(withHeureDebut: test2 as NSDate, withHeureFin: test3 as NSDate)
                for typeavis in typeAvis {
                    avis = try avisDAO.create(withChoix: false, withCommentaire: nil, belongs_to: traceur!, is_a: typeavis)
                }
                rdv = try rdvDAO.create(withName: nomField.text!, withDateTheorique: test3 as NSDate, withLieu: selectedMedecin?.adresse!, withTempsPourAllerALEvenement: Int16(tempsField.text!)!, withDuree: Int16(dureeField.text!)!, schedule_by: patient, has: traceur!, is_with: selectedMedecin!)
            } else {
                rdv = try rdvDAO.create(withName: nomField.text!, withDateTheorique: test3 as NSDate, withLieu: selectedMedecin?.adresse!, withTempsPourAllerALEvenement: Int16(tempsField.text!)!, withDuree: Int16(dureeField.text!)!, schedule_by: patient, is_with: selectedMedecin!)
            }
            
            // MARK: - Creation Notifications
            //Creation des notifications pour chaque RDV (1 notification 1h avant le RDV, 1 notification 30min avant le RDV)
            var intervaleHeure1 = rdv?.dateTheorique.timeIntervalSinceNow

            let tempsPrepa = Double(patient.tempsPreparation * 60)
            let tempsAller = Double((rdv?.tempsPourAllerALEvenement)!*60)
            
            //calcul de l'intervalleTemps pour 1h avant le RDV
            intervaleHeure1 = intervaleHeure1!-(tempsPrepa+tempsAller)
            //calcul de l'intervalleTemps pour 30min avant le RDV
            let intervaleHeure2 = intervaleHeure1!+tempsPrepa
            
            //Création du contenu de la notification
            let content = UNMutableNotificationContent()
            content.title = (rdv?.nom)!
            dateFormatter.dateFormat = "HH:mm"
            let heure = dateFormatter.string(from: rdv?.dateTheorique as! Date)
            content.subtitle = heure
            content.body = (rdv?.lieu)!
            content.badge = 1
        
            //ajout des notifications
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervaleHeure1!, repeats: false)
            let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: intervaleHeure2, repeats: false)
            let request = UNNotificationRequest(identifier: (rdv?.nom)!+"\(1)", content: content, trigger: trigger)
            let request1 = UNNotificationRequest(identifier: (rdv?.nom)!+"\(2)", content: content, trigger: trigger1)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            UNUserNotificationCenter.current().add(request1, withCompletionHandler: nil)
            
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "agenda", sender: self)
    }
    
    // MARK: - Faire lien avec l'agenda
    //Fonction qui fait le lien avec l'agenda
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
