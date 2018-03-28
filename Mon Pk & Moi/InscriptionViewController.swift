//
//  InscriptionViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class InscriptionViewController: UIViewController {

    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var dateNaissance: UITextField!
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var tempsPreparation: UITextField!
    
    let datePicker = UIDatePicker()
    
    func createDatePicker(){
        
        // format for picker
        datePicker.datePickerMode = .date
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //barButton item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateNaissance.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        dateNaissance.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "FR-fr")
    }
    
    func donePressed(){
        // format date 
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        dateNaissance.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createDatePicker()
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


    
    
    @IBAction func creer(_ sender: Any) {
        guard let lastName = nom.text, !(nom.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer votre nom.", onView: self)
            return
        }
        
        guard let firstName = prenom.text, !(prenom.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer votre prenom.", onView: self)
            return
        }
        
        guard let birthdate = dateNaissance.text, !(dateNaissance.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer votre date de naissance.", onView: self)
            return
        }
        
        guard let adress = adresse.text, !(adresse.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer votre adresse.", onView: self)
            return
        }
        
        guard let tempsPrepa = Int(tempsPreparation.text!), !(tempsPreparation.text?.isEmpty)! else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez entrer votre temps de preparation nécessaire avant de devir partir à un rendez-vous.", onView: self)
            return
        }
        
        do{
            let _ = try CoreDataDAOFactory.getInstance().getPatientDAO().create(withName: lastName, withPrenom: firstName, withDateNaissance: datePicker.date as NSDate, withAdresse: adress, withTempsPreparation: Int16(tempsPrepa))
            let storyboard = UIStoryboard.init(name: "Main",bundle: nil)
            let view = storyboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
        }

    }
    
    
    
}
