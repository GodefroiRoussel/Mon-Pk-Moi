//
//  ParametrerTraceurViewController.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 04/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class ParametrerTraceurViewController: UIViewController {

    @IBOutlet weak var heureDebutTraceur: UIDatePicker!

    @IBOutlet weak var heureFinTraceur: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            heureDebutTraceur.locale = Locale(identifier: "FR-fr")
            heureDebutTraceur.datePickerMode = .time
            
            heureFinTraceur.locale = Locale(identifier: "FR-fr")
            heureFinTraceur.datePickerMode = .time
        } catch {
            print("error")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func annulerParameters(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    let goTraceur = "goTraceur"
    
    @IBAction func saveParameters(_ sender: Any) {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let heureStartTraceur = dateFormatter.string(from: heureDebutTraceur.date)
        let heureEndTraceur = dateFormatter.string(from: heureFinTraceur.date)
        UserDefaults.standard.set(heureStartTraceur, forKey: "hourStartTraceur")
        UserDefaults.standard.set(heureEndTraceur, forKey: "hourEndTraceur")
        self.performSegue(withIdentifier: goTraceur, sender: self)
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == self.goTraceur {
            let _ = segue.destination as! TraceurSyntheseViewController
        }
    }
    

}
