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
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
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
            
            print(aprise.estEffectue)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refuserPrise(_ sender: Any) {
        
        self.prise?.estEffectue = false
        self.prise?.dateEffective = prise?.dateTheorique
        let priseMedicamenteuseDAO: PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        do {
            //DialogBoxHelper.alert(withTitle: "Prise", andMessage: "La prise a été refusée", onView: self)
            try priseMedicamenteuseDAO.update(aPriseMedicamenteuse: self.prise!)
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
            
        }
        
        self.performSegue(withIdentifier: "pilulier", sender: self)
    }

    @IBAction func validerPrise(_ sender: Any) {
        
        self.prise?.estEffectue = true
        self.prise?.dateEffective = heurePicker.date as NSDate?
        let priseMedicamenteuseDAO: PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        do {
            //DialogBoxHelper.alert(withTitle: "Prise", andMessage: "La prise a été validée", onView: self)
            try priseMedicamenteuseDAO.update(aPriseMedicamenteuse: self.prise!)
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "pilulier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
