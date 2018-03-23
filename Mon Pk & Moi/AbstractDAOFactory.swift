//
//  AbstractDAOFactory.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 17/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

protocol AbstractDAOFactory {
    associatedtype A
    associatedtype B
    associatedtype C
    associatedtype D
    
    
    func getMedicamentDAO() -> A
    func getTypeContactDAO() -> B
    func getContactDAO() -> C
    func getPatientDAO() -> D
}
