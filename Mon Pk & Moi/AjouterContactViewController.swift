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
        typeContactLabel.textAlignment = .center
        typeContactLabel.placeholder = "Choisir un type de contact"

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
