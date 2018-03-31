//
//  RemplirTraceurViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class RemplirTraceurViewController: UIViewController {

    var traceurEnCours:Traceur? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let factory: CoreDataDAOFactory = CoreDataDAOFactory.getInstance()
        let traceurDAO : TraceurDAO = factory.getTraceurDAO()
        //traceurEnCours = traceurDAO.getTraceurEnCours()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func unwindToRemplirTraceurAfterSavingPlageHoraire(segue: UIStoryboardSegue){
        let newPlageHoraireController = segue.source as! newPlageHoraireController
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
