//
//  AvisTableViewCell.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 01/04/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

class AvisTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var reponseLabel: UILabel!
    @IBOutlet weak var commentaireLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
