//
//  EvenementDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 18/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol EvenementDAO {

    func getAllEvenements() throws -> [Evenement]
    
}
