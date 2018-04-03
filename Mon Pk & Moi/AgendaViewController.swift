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
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Recuperation allEvenements
        //Récupération de tous les événements qui ne sont pas encore passé (supérieur à la date du jour)
        let evenementDAO : EvenementDAO = factory.getEvenementDAO()
        do {
            allEvenements = try evenementDAO.getAllEvenements()
            for eve in allEvenements {
                if Date() <= eve.dateTheorique as Date {
                    evenements.append(eve)
                }
            }
            
            // MARK: - Trie TableView
            //Trie de la TableView selon la date de chaque evenement
            evenements.sort(by: { (element0, element1) -> Bool in
                if element0.dateTheorique as Date > element1.dateTheorique as Date {
                    return false
                }
                
                return true
            })
        }catch let error as NSError {
            print("error")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
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
    
    // MARK: - Suppression
    //Fonction qui permet de supprimer un evenement de la TableView (check si il s'agit d'une activite ou d'un RDV)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let activiteDAO: ActiviteDAO = factory.getActiviteDAO()
            let rdvDAO: RDVDAO = factory.getRDVDAO()
            do {
                if try rdvDAO.find(withName: evenements[indexPath.row].nom) == nil {
                    try activiteDAO.delete(anActivite: evenements[indexPath.row] as! Activite)
                } else {
                    try rdvDAO.delete(aRDV: evenements[indexPath.row] as! RDV)
                }
            } catch let error as NSError {
                print("error")
            }
            evenements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //Fonction qui permet fait le lien avec l'ajout de RDV
    @IBAction func unwindToAgendaAfterSavingRDV(segue: UIStoryboardSegue){
        self.evenementsTable.reloadData()
    }
    
    //Fonction qui permet de faire le lien avec l'ajout d'activité
    @IBAction func unwindToAgendaAfterSavingActivite(segue: UIStoryboardSegue){
        self.evenementsTable.reloadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

}
