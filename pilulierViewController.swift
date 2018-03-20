//
//  pilulierViewController.swift
//  Mon Pk & Moi
//
//  Created by romain on 13/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class pilulierViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var medicaments : [String] = ["MODOPAR","SINEMET"]
    var doses : [String] = ["125","250"]
    
    @IBOutlet weak var priseMedicamentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medicaments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.priseMedicamentTable.dequeueReusableCell(withIdentifier: "priseMedicamentCell", for: indexPath)
            as! PriseMedicamentTableViewCell
        cell.medicamentNameLabel.text = self.medicaments[indexPath.row]
        cell.doseLabel.text = self.doses[indexPath.row]
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
