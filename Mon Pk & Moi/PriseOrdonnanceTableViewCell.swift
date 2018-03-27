//
//  PriseOrdonnanceTableViewCell.swift
//  Mon Pk & Moi
//
//  Created by romain on 27/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class PriseOrdonnanceTableViewCell: UITableViewCell {

    @IBOutlet weak var nomMedicamentLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var heureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
