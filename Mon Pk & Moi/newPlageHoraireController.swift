//
//  newPlageHoraireController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class newPlageHoraireController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var heureDebutPlageHoraire: NSDate? = nil
    
    var dates: [NSDate] = []
    var times: [String] = []
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        do {
            let traceur: Traceur? = try CoreDataDAOFactory.getInstance().getTraceurDAO().getTraceurEnCours()
            dates = DateHelper.getHours(hourD: traceur!.heureDebutJournee , hourF: traceur!.heureFinJournee)
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            for i in 0..<dates.count-1 {
                let heureDeb: String = dateFormatter.string(from: dates[i] as Date)
                let heureFin: String = dateFormatter.string(from: dates[i+1] as Date)
                let heure: String = "\(heureDeb) - \(heureFin)"
                times.append(heure)
            }
        } catch {
            
        }

        //TODO calculer le nombre d'heures entre heure début et heure fin
        //Le rentrer dans un tableau de String

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
        return times.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        heureDebutPlageHoraire = dates[row]
        return times[row]
    }
    
    // MARK: - Buttons
    
    @IBAction func cancel(_ sender: Any) {
        
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
