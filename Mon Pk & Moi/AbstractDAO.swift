//
//  AbstractDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 17/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import UIKit

protocol AbstractDAO {
    
    associatedtype T
    associatedtype A
    
    func create(an object: T) throws -> T
    
    //TO DO: voir quoi passer en paramètre
    func find(a reference: A) throws -> T
    
    func update(an object: T) throws -> T
    
    func delete(an object: T) throws
    
    
}
