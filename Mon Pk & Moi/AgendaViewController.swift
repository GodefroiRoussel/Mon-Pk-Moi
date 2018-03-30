//
//  AgendaViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AgendaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var evenementsTable: UITableView!
    var allEvenements: [Evenement] = []
    var evenements: [Evenement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let evenementDAO : EvenementDAO = factory.getEvenementDAO()
        do {
            allEvenements = try evenementDAO.getAllEvenements()
            for eve in allEvenements {
                if Date() <= eve.dateTheorique as Date {
                    evenements.append(eve)
                }
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
        return self.evenements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.evenementsTable.dequeueReusableCell(withIdentifier: "evenementCell", for: indexPath)
            as! EvenementTableViewCell
        cell.nomLabel.text = self.evenements[indexPath.row].nom
        let dateTheorique = self.evenements[indexPath.row].dateTheorique
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: dateTheorique as Date)
        cell.dateLabel.text = date
        dateFormatter.dateFormat = "HH:mm"
        let heure = dateFormatter.string(from: dateTheorique as Date)
        cell.heureLabel.text = heure
        return cell
    }
    
    @IBAction func unwindToAgendaAfterSavingRDV(segue: UIStoryboardSegue){
        self.evenementsTable.reloadData()
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
