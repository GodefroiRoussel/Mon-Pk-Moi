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
    typealias B = TypeContactCoreDataDAO
    
    private static var instance: CoreDataDAOFactory = CoreDataDAOFactory()
    
    private init(){}
    
    static func getInstance() -> CoreDataDAOFactory{
        return self.instance
    }

    func getMedicamentDAO() -> MedicamentCoreDataDAO {
        return MedicamentCoreDataDAO()
    }
    
    func getTypeContactDAO() -> TypeContactCoreDataDAO {
        return TypeContactCoreDataDAO()
    }

}
