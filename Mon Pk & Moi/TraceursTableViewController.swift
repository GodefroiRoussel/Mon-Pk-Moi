//
//  TraceursTableViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 01/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class TraceursTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var traceurs: [Traceur] = []
    
    @IBOutlet weak var traceurTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let factory = CoreDataDAOFactory.getInstance()
        do {
            let traceurDAO: TraceurDAO = factory.getTraceurDAO()
            traceurs = try traceurDAO.getAllTraceurs()
            
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.traceurs.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.traceurTableView.dequeueReusableCell(withIdentifier: "traceurCell", for: indexPath) as! TraceurTableViewCell
        let dateTheorique = self.traceurs[indexPath.row].belongs_to!.dateTheorique
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        cell.dateRDVLabel.text = dateFormatter.string(from: dateTheorique as Date)
        
        if dateTheorique.isGreaterThanDate(dateToCompare: NSDate()) {
            if DateHelper.checkInterval(dateRDV: dateTheorique, interval: 5) {
                cell.etatLabel.text = "En cours"
            } else {
                cell.etatLabel.text = "En attente"
            }
        } else {
            cell.etatLabel.text = "Fini"
        }

        return cell
    }
    
    // MARK: - Navigation

    //Envoyer une donnée vers la prochaine page
    let segueShowSyntheseId = "showSyntheseSegue"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.segueShowSyntheseId {
            if let indexPath = self.traceurTableView.indexPathForSelectedRow{
                let syntheseViewController = segue.destination as! SyntheseViewController
                syntheseViewController.traceur = self.traceurs[indexPath.row]
                self.traceurTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    

}
