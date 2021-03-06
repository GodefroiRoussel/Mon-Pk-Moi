//
//  SyntheseViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 01/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class SyntheseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let factory = CoreDataDAOFactory.getInstance()
    
    var traceur: Traceur? = nil
    var evaluations: [Evaluation] = []
    var prises: [PriseMedicamenteuse] = []
    var medicamentsNonPris: [PriseMedicamenteuse] = []
    var avis: [Avis] = []
    var avi: [Avis] = []
    var activites: [Activite] = []
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var titreLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addAvis(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let evaluationDAO: EvaluationDAO = factory.getEvaluationDAO()
        let priseDAO: PriseMedicamenteuseDAO = factory.getPriseMedicamenteuseDAO()
        let avisDAO: AvisDAO = factory.getAvisDAO()
        
        
        do {
            evaluations = try evaluationDAO.getAllEvaluations() //TODO: Changer en évaluation pour ce traceur
            prises = try priseDAO.getAllPriseMedicamenteuses()
            medicamentsNonPris = self.keepUntakenPrises(forPrises: self.keepOnlyPrisesForLastFiveDays(withDateRDV: (traceur?.belongs_to?.dateTheorique)!))
            avis = try avisDAO.getAllAvis() //TODO: Changer en tous les avis pour ce traceur
            for index in avis {
                if index.belongs_to == traceur {
                    avi.append(index)
                }
            }
            activites = self.activitesForLastFiveDays(withDateRDV: (traceur?.belongs_to?.dateTheorique)!)
            titreLabel.text = "Les évaluations du patient"
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func keepOnlyPrisesForLastFiveDays(withDateRDV dateRDV: NSDate) -> [PriseMedicamenteuse] {
        var newPrises: [PriseMedicamenteuse] = []

        // We retrieve the start of the first day of the traceur
        let dateDebut: NSDate = DateHelper.startOfDay(day: DateHelper.addDays(dayD: dateRDV, nbDaysToAdd: -6))
        let dateDebutRDV: NSDate = DateHelper.startOfDay(day: dateRDV)
        
        for prise in prises {
            if prise.dateTheorique.isGreaterThanDate(dateToCompare: dateDebut) && prise.dateTheorique.isLessThanDate(dateToCompare: dateDebutRDV) {
                newPrises.append(prise)
            }
        }
        return newPrises
    }
    
    func keepUntakenPrises(forPrises prises: [PriseMedicamenteuse]) -> [PriseMedicamenteuse] {
        medicamentsNonPris.removeAll()
        var prisesUntaken: [PriseMedicamenteuse] = []
        for prise in prises {
            // If the prise isn't effectuated, we consider that he didn't take the prise
            if prise.dateEffective != nil {
                //Then we calculate the time between the theoric date and the effective date and we check if there is an interval of 15 minutes or more
                let timeBetweenDates: TimeInterval = prise.dateTheorique.timeIntervalSince(prise.dateEffective! as Date)
                if timeBetweenDates > 60 * 15 {
                    prisesUntaken.append(prise)
                }
            } else {
                prisesUntaken.append(prise)
            }
        }
        return prisesUntaken
        
    }
    
    
    func activitesForLastFiveDays(withDateRDV dateRDV: NSDate) -> [Activite] {
        var lastActivites: [Activite] = []
        
        // We retrieve the start of the first day of the traceur
        let dateDebut: NSDate = DateHelper.startOfDay(day: DateHelper.addDays(dayD: dateRDV, nbDaysToAdd: -6))
        
        do {
            let activiteDAO: ActiviteDAO = factory.getActiviteDAO()
            let activites: [Activite] = try activiteDAO.getAllActivites()
            for activite in activites {
                if activite.dateTheorique.isGreaterThanDate(dateToCompare: dateDebut) && activite.dateTheorique.isLessThanDate(dateToCompare: dateRDV) {
                    lastActivites.append(activite)
                }
            }
        } catch {
            print("error")
        }

        return lastActivites
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        tableView.reloadData()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            titreLabel.text = "Les évaluations du patient"
        case 1:
            titreLabel.text = "Médicaments non pris au cours des 5 derniers jours"
        case 2:
            titreLabel.text = "Avis du médecin"
        case 3:
            titreLabel.text = "Liste des activités des 5 derniers jours"
        default :
            break
        }
    }
    
    
    // Mark: - Table View function
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return self.evaluations.count
        case 1:
            return self.medicamentsNonPris.count
        case 2:
            return self.avi.count
        case 3:
            return self.activites.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     switch segmentedControl.selectedSegmentIndex {
     //We begin with the case 'Medicament'
     case 1:
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "priseCell", for: indexPath)
            as! PriseTableViewCell
        dateFormatter.dateFormat = "dd/MM - HH:mm"
        cell.datePriseLabel.text = dateFormatter.string(from: self.medicamentsNonPris[indexPath.row].dateTheorique as Date)
        cell.medicamentLabel.text = self.medicamentsNonPris[indexPath.row].belongs_to?.nom
        cell.doseLabel.text = String(self.medicamentsNonPris[indexPath.row].dose)
        return cell
     case 2:
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "avisCell", for: indexPath)
            as! AvisTableViewCell
        print(self.avi[indexPath.row])
        cell.questionLabel.text = self.avi[indexPath.row].is_a!.libelle
        return cell
     case 3:
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "activiteCell", for: indexPath)
            as! ActiviteTableViewCell
        dateFormatter.dateFormat = "dd/MM - HH:mm"
        cell.dateLabel.text = dateFormatter.string(from: self.activites[indexPath.row].dateTheorique as Date)
        cell.nomLabel.text = self.activites[indexPath.row].nom
        return cell
     default:
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "evaluationCell", for: indexPath)
            as! EvaluationTableViewCell
        dateFormatter.dateFormat = "HH:mm"
        let heureDeb: String = dateFormatter.string(from: evaluations[indexPath.row].heureDebut as Date)
        let heureFin: String = dateFormatter.string(from: evaluations[indexPath.row].heureFin as Date)
        dateFormatter.dateFormat = "dd/MM"
        let date: String = dateFormatter.string(from: evaluations[indexPath.row].heureDebut as Date)
        let heure: String = "\(date) - \(heureDeb) - \(heureFin)"
        
        cell.plageLabel.text = heure
        cell.etatLabel.text = self.evaluations[indexPath.row].etat
        //TODO : rajouter les symptomes
        if ((evaluations[indexPath.row].can_have?.count)! >= 1) {
            cell.symptomesLabel.text = "Oui"
        } else {
            cell.symptomesLabel.text = "Non"
        }
        return cell
     }
    }
    
    let segueShowAvisId = "showAvisId"
    let segueShowActiviteId = "ShowActiviteId"
    let segueShowEvaluationId = "ShowEvaluationId"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segueShowAvisId {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let showAvisViewController = segue.destination as! ShowAvisViewController
                showAvisViewController.avis = self.avi[indexPath.row]
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        if segue.identifier == self.segueShowActiviteId {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let showActiviteViewController = segue.destination as! ShowActiviteViewController
                showActiviteViewController.activite = self.activites[indexPath.row]
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        if segue.identifier == self.segueShowEvaluationId {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let showEvaluationViewController = segue.destination as! ShowEvaluationViewController
                showEvaluationViewController.evaluation = self.evaluations[indexPath.row]
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
    
    
    
    @IBAction func unwindToSyntheseAfterModifieAvis(segue: UIStoryboardSegue){
        self.tableView.reloadData()
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
