//
//  CoreDataDAOFactory.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 17/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDAOFactory: AbstractDAOFactory{
    typealias A = MedicamentCoreDataDAO
    
    private static var instance: CoreDataDAOFactory?
    
    private init(){}
    
    static func getInstance() -> CoreDataDAOFactory{
        guard let instanceFactory = CoreDataDAOFactory.instance else {
            return CoreDataDAOFactory()
        }
        return instanceFactory
    }

    func getMedicamentDAO() -> MedicamentCoreDataDAO {
        return MedicamentCoreDataDAO()
    }

}
