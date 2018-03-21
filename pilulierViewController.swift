//
//  pilulierViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 13/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class pilulierViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var medicaments : [String] = []
    var doses : [Double] = []
    var times : [String] = []

    
    @IBOutlet weak var priseMedicamentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.priseMedicamentTable.dequeueReusableCell(withIdentifier: "priseMedicamentCell", for: indexPath)
            as! PriseMedicamentTableViewCell
        cell.medicamentNameLabel.text = self.medicaments[indexPath.row]
        cell.doseLabel.text = "\(doses[indexPath.row])"
        cell.timeLabel.text = times[indexPath.row]
        return cell
    }
    
   // func SaveNewPrise(withMedicament medicament: String, andDose dose: Double, andTime time: Date){
     //   guard let context = self.getContext(errorMsg: "Save failed") else { return }
       // let priseMedicameuteuse = PriseMedicamenteuse(context: context)
        //priseMedicameuteuse.dose
   // }
    
    @IBAction func unwindToPriseListAfterSavingNewPrise(segue: UIStoryboardSegue){
        let ajouterPriseController = segue.source as! AjouterPriseViewController
        let medicament = ajouterPriseController.medicamentField.text ?? ""
        let dose = ajouterPriseController.doseField.text
        let time = ajouterPriseController.timeField.text ?? ""
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .none
        //dateFormatter.timeStyle = .short
        //dateFormatter.locale = Locale(identifier: "FR-fr")
        //let serverTime = dateFormatter.date(from: time)!

        
        
        self.medicaments.append(medicament)
        self.doses.append(Double(dose!)!)
        self.times.append(time)
        self.priseMedicamentTable.reloadData()
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
