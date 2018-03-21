//
//  AjouterOrdonnanceViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 21/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterOrdonnanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var medecinField: UITextField!
    @IBOutlet weak var prochainRDVField: UITextField!
    
    let medecins = ["Neurologue","Ophtalmologue"]
    var medicaments : [String] = ["Doliprane"]
    var doses : [Double] = [125.0]
    var times : [String] = ["11:15"]
    
        var pickerView = UIPickerView()
        let pickerDate = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        
        pickerView.delegate = self
        
        medecinField.inputView = pickerView
        medecinField.textAlignment = .center
        medecinField.placeholder = "Choisir un médecin"
        
        prochainRDVField.textAlignment = .center
        prochainRDVField.placeholder = "Choisir une date"

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
            return medecins[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        medecinField.text = medecins[row]
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
