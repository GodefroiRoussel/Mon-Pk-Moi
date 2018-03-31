//
//  RemplirTraceurViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class RemplirTraceurViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var traceurEnCours: Traceur? = nil
    var heureDebut: NSDate? = nil
    var heureFin: NSDate? = nil
    var etatChoisi: String? = nil
    var symptomes: [Symptome] = []
    
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
            traceurEnCours = try traceurDAO.getTraceurEnCours()
            plageHoraireLabel.text = ""
            etatLabel.text = ""
        } catch {
            
        }
        
        getCurrentDateTime()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCurrentDateTime(){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "FR-fr")
        let str = formatter.string(from: Date())
        dateLabel.text = str
    }
    
    
    @IBAction func saveEvaluation(_ sender: Any) {
    }
    
    
    @IBAction func jourSubButton(_ sender: Any) {
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

    }
    
    
    @IBAction func jourAddButton(_ sender: Any) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
