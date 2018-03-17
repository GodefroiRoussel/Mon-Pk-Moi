//
//  MedicamentDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit
import CoreData

protocol MedicamentDAO {
    func getAllMedicaments() throws -> [Medicament]

}
