//
//  PriseMedicamentTableViewCell.swift
//  Mon Pk & Moi
//
//  Created by romain on 13/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class PriseMedicamentTableViewCell: UITableViewCell {

    @IBOutlet weak var medicamentNameLabel: UILabel!
    @IBOutlet weak var doseLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
