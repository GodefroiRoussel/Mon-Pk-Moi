//
//  pilulierViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 13/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class pilulierViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    var allPriseMedicamenteuses : [PriseMedicamenteuse] = []
    var priseMedicamenteuses : [PriseMedicamenteuse] = []
    
    @IBOutlet weak var priseMedicamentTable: UITableView!
    
    @IBAction func jourAddButton(_ sender: UIButton) {
        let date = dateLabel.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let test = dateFormatter.date(from: date!)
        let test2 = Date(timeInterval: 86400, since: test!)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: test2)
        dateLabel.text = str
        
        self.loadData()
        priseMedicamentTable.reloadData()
    }
    @IBAction func jourSubButton(_ sender: UIButton) {
        let date = dateLabel.text
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "FR-fr")
        let test = dateFormatter.date(from: date!)
        let test2 = Date(timeInterval: -86400, since: test!)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: test2)
        dateLabel.text = str
        
        self.loadData()
        priseMedicamentTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentDateTime()
        self.loadData()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.priseMedicamenteuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.priseMedicamentTable.dequeueReusableCell(withIdentifier: "priseMedicamentCell", for: indexPath)
            as! PriseMedicamentTableViewCell
        cell.medicamentNameLabel.text = self.priseMedicamenteuses[indexPath.row].belongs_to?.nom
        cell.doseLabel.text = "\(self.priseMedicamenteuses[indexPath.row].dose)"

        let dateTheorique = self.priseMedicamenteuses[indexPath.row].pdateTheorique
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let heure = dateFormatter.string(from: dateTheorique as! Date)
        cell.timeLabel.text = heure
        if priseMedicamenteuses[indexPath.row].pdateEffective == nil {
            cell.etatLabel.text = "en attente"
        } else {
            if priseMedicamenteuses[indexPath.row].estEffectue == false {
                cell.etatLabel.text = "refusée"
            } else {
                cell.etatLabel.text = "validée"
            }
        }
        return cell
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: Date())
        dateLabel.text = str
    }
    
    @IBAction func unwindToPilulierAfterSavingNewOrdonnance(segue: UIStoryboardSegue){
        self.loadData()
        self.priseMedicamentTable.reloadData()
    }
    
    @IBAction func unwindToPilulierAfterValidatePrise(segue: UIStoryboardSegue){
        self.priseMedicamentTable.reloadData()
    }
    
    func loadData(){
        priseMedicamenteuses.removeAll()
        allPriseMedicamenteuses.removeAll()
        let priseMedicamenteuseDAO : PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        do {
            allPriseMedicamenteuses = try priseMedicamenteuseDAO.getAllPriseMedicamenteuses()
            for prise in allPriseMedicamenteuses {
                
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                formatter.locale = Locale(identifier: "FR-fr")
                let str = formatter.string(from: prise.dateTheorique as Date)
                
                if dateLabel.text! == str {
                    priseMedicamenteuses.append(prise)
                }
                priseMedicamenteuses.sort(by: { (element0, element1) -> Bool in
                    if element0.dateTheorique as Date > element1.dateTheorique as Date {
                        return false
                    }
                    
                    return true
                })
            }
        } catch let error as NSError {
            print("error")
        }

    }
    
    let segueShowPriseId = "ShowPriseSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowPriseId {
            if let indexPath = self.priseMedicamentTable.indexPathForSelectedRow {
                let showPriseViewController = segue.destination as! ShowPriseViewController
                showPriseViewController.prise = self.priseMedicamenteuses[indexPath.row]
                self.priseMedicamentTable.deselectRow(at: indexPath, animated: true)
            }
        }
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
