//
//  RemplirTraceurViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class RemplirTraceurViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var heureDebut: NSDate? = nil
    var heureFin: NSDate? = nil
    var etatChoisi: String? = nil
    var symptomes: [Symptome] = []
    var traceur: Traceur? = nil
    var date: NSDate? = nil
    
    @IBOutlet weak var flecheGauche: UIButton!
    @IBOutlet weak var flecheDroite: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var plageHoraireLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var symptomeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let traceurDAO : TraceurDAO = factory.getTraceurDAO()
        do {
            traceur = try traceurDAO.getTraceurEnCours()
            plageHoraireLabel.text = ""
            etatLabel.text = ""
        } catch {
            
        }
        
        getCurrentDateTime()
        
        if firstDayOfTraceur() {
            flecheGauche.isHidden = true
        } else if lastDayOfTraceur() {
            flecheDroite.isHidden = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firstDayOfTraceur() -> Bool {
        var firstDayOfTraceur: NSDate = DateHelper.addDays(dayD: (traceur?.belongs_to?.dateTheorique)!, nbDaysToAdd: -5)
        firstDayOfTraceur = DateHelper.endOfDay(day: firstDayOfTraceur)
        return date!.isLessThanDate(dateToCompare: firstDayOfTraceur)
    }
    
    func lastDayOfTraceur() -> Bool {
        var lastDayOfTraceur: NSDate = DateHelper.addDays(dayD: (traceur?.belongs_to?.dateTheorique)!, nbDaysToAdd: -1)
        lastDayOfTraceur = DateHelper.startOfDay(day: lastDayOfTraceur)
        return date!.isGreaterThanDate(dateToCompare: lastDayOfTraceur)
    }
    
    func getCurrentDateTime(){
        date = NSDate()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: date as! Date)
        dateLabel.text = str
    }
    
    @IBAction func jourSubButton(_ sender: Any) {
        date = DateHelper.addDays(dayD: date!, nbDaysToAdd: -1)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: date as! Date)
        dateLabel.text = str
        
        flecheDroite.isHidden = false
        if firstDayOfTraceur() {
            flecheGauche.isHidden = true
        } else {
            flecheGauche.isHidden = false
        }
    }
    
    
    @IBAction func jourAddButton(_ sender: Any) {
        date = DateHelper.addDays(dayD: date!, nbDaysToAdd: 1)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: date as! Date)
        dateLabel.text = str
        
        flecheGauche.isHidden = false
        if lastDayOfTraceur() {
            flecheDroite.isHidden = true
        } else {
            flecheDroite.isHidden = false
        }
    }
    
    
    @IBAction func unwindToRemplirTraceurAfterSavingPlageHoraire(segue: UIStoryboardSegue){
        let newPlageHoraireController = segue.source as! newPlageHoraireController
        heureDebut = newPlageHoraireController.heureDebutPlageHoraire
        heureFin = DateHelper.addHours(hourD: heureDebut!, nbHoursToAdd: 1)
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strHeureDebut: String = dateFormatter.string(from: heureDebut! as Date)
        let strHeureFin: String = dateFormatter.string(from: heureFin! as Date)
        plageHoraireLabel.text = "\(strHeureDebut) - \(strHeureFin)"
    }
    
    
    @IBAction func unwindToRemplirTraceurAfterSelectingEtat(segue: UIStoryboardSegue){
        let newEtatViewController = segue.source as! newEtatViewController
        etatChoisi = newEtatViewController.etatChoisi
        etatLabel.text = etatChoisi!
    }
    
    @IBAction func unwindToRemplirTraceurAfterSelectingSymptome(segue: UIStoryboardSegue){
        let newSymptomeController = segue.source as! NewSymptomeViewController
        symptomes.append(newSymptomeController.symptomeSelected!)
        symptomeTableView.reloadData()
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveEvaluation(_ sender: Any) {
        guard let _ = heureDebut else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuillez choisir une plage horaire.", onView: self)
            return
        }
        
        guard let _ = heureFin else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Une erreur a eu lieu, veuillez réessayer plus tard.", onView: self)
            return
        }
        
        guard let _ = etatChoisi else {
            DialogBoxHelper.alert(withTitle: "Valeur(s) manquante(s)", andMessage: "Veuilez définir votre état.", onView: self)
            return
        }

        //Start the business logic
        let factory = CoreDataDAOFactory.getInstance()
        let evaluationDAO: EvaluationDAO = factory.getEvaluationDAO()
        let traceurDAO: TraceurDAO = factory.getTraceurDAO()
        let dateEtHeureDebut: NSDate = DateHelper.changeHour(date: date!, heureMin: heureDebut!)
        let dateEtHeureFin: NSDate = DateHelper.changeHour(date: date!, heureMin: heureFin!)
        
        do {
            let traceur: Traceur? = try traceurDAO.getTraceurEnCours()
            let evaluation: Evaluation = try evaluationDAO.create(withEtat: etatChoisi!, withHeureDebut: dateEtHeureDebut, withHeureFin: dateEtHeureFin, is_linked: traceur!)
            
            for symptome in symptomes {
                evaluation.addToCan_have(symptome)
            }
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Table View functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symptomes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.symptomeTableView.dequeueReusableCell(withIdentifier: "symptomeCell", for: indexPath)
            as! SymptomeTableViewCell
        cell.libelleLabel.text = self.symptomes[indexPath.row].libelle
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
