//
//  AgendaViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController {

    @IBOutlet weak var evenementsTable: UITableView!
    
    var jours : [String] = []
    var noms : [String] = []
    var heures : [String] = []
    
    var dates : [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let evenementDAO : EvenementDAO = factory.getEvenementDAO()
        do {
            let evenements: [Evenement] = try evenementDAO.getAllEvenements()
            for evenement in evenements {
                noms.append(evenement.pnom!)
                dates.append(evenement.dateTheorique as Date)
            }
            
        }catch let error as NSError {
            print("error")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.evenementsTable.dequeueReusableCell(withIdentifier: "evenementCell", for: indexPath)
            as! EvenementTableViewCell
        cell.nomLabel.text = self.noms[indexPath.row]
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        for date in dates {
            let heure = dateFormatter.string(from: date)
            jours.append(heure)
        }
        cell.dateLabel.text = jours[indexPath.row]
        
        dateFormatter.dateFormat = "HH:mm"
        for date in dates {
            let heure = dateFormatter.string(from: date)
            heures.append(heure)
        }
        cell.dateLabel.text = heures[indexPath.row]
        
        return cell
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