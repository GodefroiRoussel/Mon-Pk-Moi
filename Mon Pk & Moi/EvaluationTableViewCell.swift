//
//  evaluationTableViewCell.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 01/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class EvaluationTableViewCell: UITableViewCell {

    @IBOutlet weak var plageLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    @IBOutlet weak var symptomesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
