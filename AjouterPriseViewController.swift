//
//  miseAJourViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 10/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit


class AjouterPriseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var medicamentField: UITextField!
    @IBOutlet weak var doseField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    let medicaments = ["Doliprane","Modopar","Sinemet","Stalevo"]
    let doses = [125.0,250.0,300.0]
    
    var pickerView = UIPickerView()
    var pickerView1 = UIPickerView()
    
    let pickerTime = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimePicker()
        
        pickerView.delegate = self
        pickerView1.delegate = self
        
        medicamentField.inputView = pickerView
        medicamentField.textAlignment = .center
        medicamentField.placeholder = "Choisir un medicament"
        
        doseField.inputView = pickerView1
        doseField.textAlignment = .center
        doseField.placeholder = "Choisir une dose"
        
        timeField.textAlignment = .center
        timeField.placeholder = "Choisir une heure"

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
            return doses.count
        }
        else{
            return medicaments.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
            return "\(doses[row])"
        } else {
        return medicaments[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            doseField.text = "\(doses[row])"
            doseField.resignFirstResponder()
        }
        else{
            medicamentField.text = medicaments[row]
            medicamentField.resignFirstResponder()
        }
    }
    
    func createTimePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedTime))
        toolbar.setItems([doneButton], animated: false)
        
        timeField.inputAccessoryView = toolbar
        timeField.inputView = pickerTime
        
        pickerTime.datePickerMode = .time
        pickerTime.locale = Locale(identifier: "FR-fr")
        
    }
    
    func donePressedTime() {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        timeFormatter.locale = Locale(identifier: "FR-fr")
        let timeString = timeFormatter.string(from: pickerTime.date)
        
        
        timeField.text = "\(timeString)"
        self.view.endEditing(true)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

