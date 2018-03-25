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
    typealias C = ContactCoreDataDAO
    typealias D = PatientCoreDataDAO
    typealias E = EvenementCoreDataDAO
    typealias F = OrdonnanceCoreDataDAO
    typealias G = PriseMedicamenteuseCoreDataDAO
    typealias H = ActiviteCoreDataDAO
    typealias I = RDVCoreDataDAO
    typealias J = TraceurCoreDataDAO
    typealias K = EvaluationCoreDataDAO
    typealias L = SymptomeCoreDataDAO
    typealias M = AvisCoreDataDAO
    typealias N = TypeAvisCoreDataDAO
    
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
    
    func getContactDAO() -> ContactCoreDataDAO {
        return ContactCoreDataDAO()
    }
    
    func getPatientDAO() -> PatientCoreDataDAO {
        return PatientCoreDataDAO()
    }
    
    func getEvenementDAO() -> EvenementCoreDataDAO {
        return EvenementCoreDataDAO()
    }
    
    func getOrdonnanceDAO() -> OrdonnanceCoreDataDAO {
        return OrdonnanceCoreDataDAO()
    }
    
    func getPriseMedicamenteuseDAO() -> PriseMedicamenteuseCoreDataDAO {
        return PriseMedicamenteuseCoreDataDAO()
    }

    func getActiviteDAO() -> ActiviteCoreDataDAO {
        return ActiviteCoreDataDAO()
    }
    
    func getRDVDAO() -> RDVCoreDataDAO {
        return RDVCoreDataDAO()
    }
    
    func getTraceurDAO() -> TraceurCoreDataDAO {
        return TraceurCoreDataDAO()
    }
    
    func getEvaluationDAO() -> EvaluationCoreDataDAO {
        return EvaluationCoreDataDAO()
    }
    
    func getSymptomeDAO() -> SymptomeCoreDataDAO {
        return SymptomeCoreDataDAO()
    }
    
    func getAvisDAO() -> AvisCoreDataDAO {
        return AvisCoreDataDAO()
    }
    
    func getTypeAvisDAO() -> TypeAvisCoreDataDAO {
        return TypeAvisCoreDataDAO()
    }
}
