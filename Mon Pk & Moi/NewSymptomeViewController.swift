//
//  NewSymptomeViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class NewSymptomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var symptomes: [Symptome] = []
    var symptomeSelected: Symptome? = nil
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            let symptomeDAO: SymptomeDAO = try CoreDataDAOFactory.getInstance().getSymptomeDAO()
            symptomes = try symptomeDAO.getAllSymptomes()
            symptomes.sort(by: { (symptome1, symptome2) -> Bool in symptome1.libelle < symptome2.libelle } )
        } catch let error as NSError {
            print(error)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return symptomes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return symptomes[row].libelle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        symptomeSelected = symptomes[row]
    }
    
    
    // MARK: - Buttons
    
   
    @IBAction func cancel(_ sender: Any) {
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
