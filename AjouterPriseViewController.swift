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
    var doses : [Double] = []
    
    //var carlist: Dictionary <String, Dictionary<Double>> = Dictionary()
    
    @IBOutlet weak var medicamentPickerView: UIPickerView!
    @IBOutlet weak var dosePickerView: UIPickerView!
    @IBOutlet weak var heurePickerView: UIDatePicker!
    
    var listOfMedicament : [String] = []
    var listOfDose : [Double] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let medicamentDAO : MedicamentDAO = factory.getMedicamentDAO()
        do {
            let medicaments: [Medicament] = try medicamentDAO.getAllMedicaments()
            for medicament in medicaments {
                nomMedicaments.append(medicament.nom)
                for dose in medicament.doses {
                    for d in doses {
                        if dose == d {
                            res = false
                        }
                    }
                    if res == true {
                        doses.append(dose)
                    }
                    res = true
                }
            }
            
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
            return listOfMedicament.count
        } else {
            return listOfDose.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
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

