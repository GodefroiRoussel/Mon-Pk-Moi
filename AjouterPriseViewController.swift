//
//  miseAJourViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 10/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit


class AjouterPriseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var medicaments: [Medicament] = []
    var selectedMedicament : Medicament? = nil
    var selectedDose : Double? = nil
    
    
    @IBOutlet weak var medicamentPickerView: UIPickerView!
    @IBOutlet weak var dosePickerView: UIPickerView!
    @IBOutlet weak var heurePickerView: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let medicamentDAO : MedicamentDAO = factory.getMedicamentDAO()
        do {
            medicaments = try medicamentDAO.getAllMedicaments()
            medicaments.sort(by: { (medicament1, medicament2) -> Bool in medicament1.nom < medicament2.nom } )
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
            return medicaments.count
        } else {
            let selection = medicamentPickerView.selectedRow(inComponent: 0)
            return medicaments[selection].doses.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == medicamentPickerView {
            return medicaments[row].nom
        } else {
            let selection = medicamentPickerView.selectedRow(inComponent: 0)
            return String(describing: medicaments[selection].doses[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == medicamentPickerView {
            selectedMedicament = medicaments[row]
            dosePickerView.reloadAllComponents()
        } else if pickerView == dosePickerView {
            let selection = medicamentPickerView.selectedRow(inComponent: 0)
            selectedDose = medicaments[selection].doses[row]
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

