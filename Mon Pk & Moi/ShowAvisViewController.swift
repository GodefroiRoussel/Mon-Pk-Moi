//
//  ShowAvisViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 03/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class ShowAvisViewController: UIViewController {

    @IBOutlet weak var nomAvisLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var commentaireField: UITextField!
    
    var avis : Avis? = nil
    
    let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let aAvis = self .avis {
            self.nomAvisLabel.text = aAvis.is_a?.libelle
            if aAvis.choix == false {
                self.switch.isOn = false
            } else {
                self.switch.isOn = true
            }
            self.commentaireField.text = aAvis.commentaire
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.avis?.choix = true
        } else {
            self.avis?.choix = false
        }
    }
    
    @IBAction func modifier(_ sender: Any) {

        self.avis?.commentaire = commentaireField.text
        
        let avisDAO: AvisDAO = factory.getAvisDAO()
        do {
            try avisDAO.update(anAvis: self.avis!)
        } catch let error as NSError {
            DialogBoxHelper.alert(onError: error, onView: self)
            return
        }
        
        self.performSegue(withIdentifier: "synthese", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
