//
//  miseAJourViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 10/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit


class miseAJourViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var medicamentField: UITextField!
    @IBOutlet weak var doseField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    let medicaments = ["Doliprane","Modopar","Sinemet","Stalevo"]
    let doses = ["125","250","300"]
    
    var pickerView = UIPickerView()
    var pickerView1 = UIPickerView()
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        medicamentField.inputView = pickerView
        medicamentField.textAlignment = .center
        medicamentField.placeholder = "Choisir un medicament"
        
        doseField.inputView = pickerView1
        doseField.textAlignment = .center
        doseField.placeholder = "Choisir une dose"
        
        dateField.textAlignment = .center
        dateField.placeholder = "Choisir une date"

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
            return doses[row]
        }
        else{
            return medicaments[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            doseField.text = doses[row]
            doseField.resignFirstResponder()
        }
        else{
            medicamentField.text = medicaments[row]
            medicamentField.resignFirstResponder()
        }
    }
        
    func createDatePicker() {
            
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
            
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
            
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
    
    }
    
    func donePressed() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        dateField.text = "\(picker.date)"
        self.view.endEditing(true)
        
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

