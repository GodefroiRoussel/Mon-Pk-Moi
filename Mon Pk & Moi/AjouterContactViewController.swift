//
//  AjouterContactViewController.swift
//  Mon Pk & Moi
//
//  Created by Romain THEVENON on 28/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AjouterContactViewController: UIViewController {

    @IBOutlet weak var nomField: UITextField!
    @IBOutlet weak var prenomField: UITextField!
    @IBOutlet weak var numeroField: UITextField!
    @IBOutlet weak var adresseField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
