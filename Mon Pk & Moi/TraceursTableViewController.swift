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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
                cell.etatLabel.text = "Fini"
            }
        } else {
            cell.etatLabel.text = "En attente"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
