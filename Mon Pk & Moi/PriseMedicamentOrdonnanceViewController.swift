//
//  PriseMedicamentOrdonnanceViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 22/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class PriseMedicamentOrdonnanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var medicaments : [String] = ["Doliprane"]
    var doses : [Double] = [125.0]
    var times : [String] = ["11:13"]
    
    @IBOutlet weak var prisesTable: UITableView!
    
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
        let cell = self.prisesTable.dequeueReusableCell(withIdentifier: "PriseMedicamentCell", for: indexPath)
            as! PriseOrdonnanceTableViewCell
        cell.nomMedicamentLabel.text = self.medicaments[indexPath.row]
        cell.doseLabel.text = "\(doses[indexPath.row])"
        cell.heureLabel.text = times[indexPath.row]
        return cell
    }
    
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
        self.prisesTable.reloadData()
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
