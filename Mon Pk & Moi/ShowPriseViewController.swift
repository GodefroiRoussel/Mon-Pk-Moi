//
//  ShowPriseViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 03/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class ShowPriseViewController: UIViewController {

    @IBOutlet weak var nomMedicamentLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    @IBOutlet weak var heurePicker: UIDatePicker!
    
    var prise : PriseMedicamenteuse? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heurePicker.locale = Locale(identifier: "FR-fr")
        heurePicker.datePickerMode = .time
        
        if let aprise = self.prise{
            self.nomMedicamentLabel.text = aprise.belongs_to?.nom
            self.doseLabel.text = "\(aprise.dose)"
            
            let dateTheorique = aprise.dateTheorique
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let heure = dateFormatter.string(from: dateTheorique as Date)
            self.heureLabel.text = heure
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refuserPrise(_ sender: Any) {
        prise?.estEffectue = false
        print("faux")
    }

    @IBAction func validerPrise(_ sender: Any) {
        prise?.estEffectue = true
        prise?.dateEffective = heurePicker.date as NSDate?
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let heure = dateFormatter.string(from: heurePicker.date)
        print(heure)
        
        print(heurePicker.date as NSDate)
        
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
