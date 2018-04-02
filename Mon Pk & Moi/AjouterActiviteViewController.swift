//
//  AjouterActiviteViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 30/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import UserNotifications

class AjouterActiviteViewController: UIViewController {

    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var heureField: UITextField!
    @IBOutlet weak var dureeField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    var activites: [Activite] = []
    var activite: Activite? = nil
    
    let pickerDate = UIDatePicker()
    let pickerTime = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        createTimePicker()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedDate))
        toolbar.setItems([doneButton], animated: false)
        
        dateField.inputAccessoryView = toolbar
        dateField.inputView = pickerDate
        
        pickerDate.locale = Locale(identifier: "FR-fr")
        pickerDate.datePickerMode = .date
        
    }
    
    func donePressedDate() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let dateString = dateFormatter.string(from: pickerDate.date)
        
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    func createTimePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTime))
        toolbar.setItems([doneButton], animated: false)
        
        heureField.inputAccessoryView = toolbar
        heureField.inputView = pickerTime
        
        pickerTime.locale = Locale(identifier: "FR-fr")
        
    }
    
    func donePressedTime() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let HeureString = dateFormatter.string(from: pickerTime.date)
        
        heureField.text = "\(HeureString)"
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
            
            let interv: TimeInterval = pickerTime.date.timeIntervalSinceNow
            print(interv)
            let dateFin = Date(timeInterval: interv, since: pickerDate.date)
            
            var dates = DateHelper.getDates(dateD: pickerTime.date as NSDate, dateF: dateFin as NSDate)
            var index: Int = 1
            var index1: Int = 2
            for dat in dates {
                activite = try activiteDAO.create(withName: nomField.text!, withDateTheorique: dat as NSDate, withDuree: Int16(dureeField.text!)!, withDescription: descriptionField.text!, schedule_by: patient)
                activites.append(activite!)
                
                //Notififcation
                var intervaleHeure1 = dat.timeIntervalSinceNow
                print(intervaleHeure1)
                intervaleHeure1 = intervaleHeure1-3600
                let intervaleHeure2 = intervaleHeure1+1800

                let content = UNMutableNotificationContent()
                content.title = (activite?.nom)!
                
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let heure = dateFormatter.string(from: activite?.dateTheorique as! Date)
                content.subtitle = heure
                content.body = (activite?.desc)!
                content.badge = 1
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervaleHeure1, repeats: false)
                let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: intervaleHeure2, repeats: false)
                let request = UNNotificationRequest(identifier: (activite?.nom)!+"\(index)", content: content, trigger: trigger)
                let request1 = UNNotificationRequest(identifier: (activite?.nom)!+"\(index1)", content: content, trigger: trigger1)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                UNUserNotificationCenter.current().add(request1, withCompletionHandler: nil)
                index = index+2
                index1 = index1+2
            }
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "agenda", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AgendaViewController
        for activite in activites {
            dest.evenements.append(activite)
        }
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
