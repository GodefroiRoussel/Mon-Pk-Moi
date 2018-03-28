//
//  miseAJourViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 10/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit


class AjouterPriseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var res : Bool = true
    
    var nomMedicaments : [String] = []
    var doses : [[Double]] = []
    
    //var carlist: Dictionary <String, Dictionary<Double>> = Dictionary()
    
    @IBOutlet weak var medicamentPickerView: UIPickerView!
    @IBOutlet weak var dosePickerView: UIPickerView!
    @IBOutlet weak var heurePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let medicamentDAO : MedicamentDAO = factory.getMedicamentDAO()
        do {
            let medicaments: [Medicament] = try medicamentDAO.getAllMedicaments()
            for medicament in medicaments {
                nomMedicaments.append(medicament.nom)
                doses.append(medicament.doses)
            }
            self.medicamentPickerView.dataSource = self
            self.medicamentPickerView.delegate = self
            
            
            self.dosePickerView.dataSource = self
            self.dosePickerView.delegate = self
            
            heurePickerView.locale = Locale(identifier: "FR-fr")
            heurePickerView.datePickerMode = .time
            
        }catch let error as NSError {
            print("error")
        }

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == medicamentPickerView {
            return nomMedicaments.count
        } else {
            let medicamentSelected = medicamentPickerView.selectedRow(inComponent: 0)
            return doses[medicamentSelected].count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == medicamentPickerView {
            return nomMedicaments[row]
        } else {
            let medicamentSelected = medicamentPickerView.selectedRow(inComponent: 0)
            return String(doses[medicamentSelected][row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == medicamentPickerView {
            dosePickerView.reloadAllComponents()
        }
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

