//
//  newEtatViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class newEtatViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    let etats: [String] = ["ON", "OFF", "DYSKINESIE"]
    var etatChoisi: String? = nil

    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        etatChoisi = etats[0]
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
        return etats.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return etats[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        etatChoisi = etats[row]
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
