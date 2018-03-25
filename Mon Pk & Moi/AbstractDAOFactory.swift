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
    associatedtype E
    associatedtype F
    associatedtype G
    associatedtype H
    associatedtype I
    associatedtype J
    associatedtype K
    associatedtype L
    associatedtype M
    
    func getMedicamentDAO() -> A
    func getTypeContactDAO() -> B
    func getContactDAO() -> C
    func getPatientDAO() -> D
    func getEvenementDAO() -> E
    func getOrdonnanceDAO() -> F
    func getPriseMedicamenteuseDAO() -> G
    func getActiviteDAO() -> H
    func getRDVDAO() -> I
    func getTraceurDAO() -> J
    func getEvaluationDAO() -> K
    func getSymptomeDAO() -> L
    func getAvisDAO() -> M
}
