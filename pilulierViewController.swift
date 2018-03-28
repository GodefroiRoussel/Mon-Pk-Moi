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
    
    var medicaments : [String] = []
    var doses : [Double] = []
    var times : [String] = []
    
    var dates : [Date] = []

    
    @IBOutlet weak var priseMedicamentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let priseMedicamenteuseDAO : PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        do {
            let priseMedicamenteuses: [PriseMedicamenteuse] = try priseMedicamenteuseDAO.getAllPriseMedicamenteuses()
            for priseMedicamenteuse in priseMedicamenteuses {
                medicaments.append((priseMedicamenteuse.belongs_to?.nom)!)
                doses.append(priseMedicamenteuse.pdose)
                dates.append(priseMedicamenteuse.pdateTheorique! as Date)
            }
            
        }catch let error as NSError {
            print("error")
        }
        
        
        getCurrentDateTime()

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
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        for date in dates {
            let heure = dateFormatter.string(from: date)
            times.append(heure)
        }
        cell.timeLabel.text = "\(times[indexPath.row])"
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
    
   // func SaveNewPrise(withMedicament medicament: String, andDose dose: Double, andTime time: Date){
     //   guard let context = self.getContext(errorMsg: "Save failed") else { return }
       // let priseMedicameuteuse = PriseMedicamenteuse(context: context)
        //priseMedicameuteuse.dose
   // }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
