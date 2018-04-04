//
//  ShowActiviteViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 04/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class ShowActiviteViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nomActiviteLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var activite: Activite? = nil
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Affecte les différents labels aux valeurs de l'activité
        if let aActivite = self.activite {
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let heure = dateFormatter.string(from: aActivite.dateTheorique as Date)
            self.dateLabel.text = heure
            self.nomActiviteLabel.text = aActivite.nom
            self.descriptionLabel.text = aActivite.pdesc
            print(aActivite)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
