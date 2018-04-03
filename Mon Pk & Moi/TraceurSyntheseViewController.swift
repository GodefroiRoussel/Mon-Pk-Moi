//
//  TraceurSyntheseViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 04/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class TraceurSyntheseViewController: UIViewController {

    @IBOutlet weak var firstButton: UIButton!
    
    let factory = CoreDataDAOFactory.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let traceurDAO: TraceurDAO = factory.getTraceurDAO()
            let traceur: Traceur? = try traceurDAO.getTraceurEnCours()
            if traceur == nil {
                firstButton.setTitle("Aucun traceur n'est actuellement en cours", for: .normal)
                firstButton.isEnabled = false
            }
        } catch {
            print("error")
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
