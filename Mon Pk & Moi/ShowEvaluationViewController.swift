//
//  ShowEvaluationViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 04/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class ShowEvaluationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var symptomesTable: UITableView!
    
    var evaluation: Evaluation? = nil
    
    let factory = CoreDataDAOFactory.getInstance()
    
    var allSymptome: [Symptome] = []
    var symptome: [Symptome] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let symptomeDAO: SymptomeDAO = factory.getSymptomeDAO()
        
        do {
            allSymptome = try symptomeDAO.getAllSymptomes()
            for symp in allSymptome {
                if symp.can_be == evaluation {
                    symptome.append(symp)
                }
            }
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
        }
        
        if let aEvaluation = self.evaluation {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let heureDeb: String = dateFormatter.string(from: aEvaluation.heureDebut as Date)
            let heureFin: String = dateFormatter.string(from: aEvaluation.heureFin as Date)
            dateFormatter.dateFormat = "dd/MM"
            let date: String = dateFormatter.string(from: aEvaluation.heureDebut as Date)
            let heure: String = "\(date) - \(heureDeb) - \(heureFin)"
            self.dateLabel.text = heure
            
            self.etatLabel.text = aEvaluation.etat
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.symptome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.symptomesTable.dequeueReusableCell(withIdentifier: "symptomeCell", for: indexPath)
            as! SymptomesTableViewCell
        cell.libelleLabel.text = symptome[indexPath.row].libelle
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
