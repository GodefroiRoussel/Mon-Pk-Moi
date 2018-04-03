//
//  EvaluationCoreDataDAO.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation
import CoreData

class EvaluationCoreDataDAO: EvaluationDAO {
    
    // MARK: - Properties functions
    
    let request : NSFetchRequest<Evaluation> = Evaluation.fetchRequest()
    
    init(){
    }
    
    // MARK: - Create function
    
    func create(withEtat etat: String, withHeureDebut heureDebut: NSDate, withHeureFin heureFin: NSDate, is_linked traceur :Traceur) throws -> Evaluation {
        let newEvaluation = Evaluation(withEtat: etat, withHeureDebut: heureDebut, withHeureFin: heureFin, is_linked: traceur)
        CoreDataManager.save()
        return newEvaluation
    }
    
    
    // MARK: - Getter functions
    func getAllEvaluations() throws -> [Evaluation] {
        do {
            let evaluations: [Evaluation] = try CoreDataManager.context.fetch(self.request)
            return evaluations
        } catch let error as NSError {
            throw error
        }
    }
    
    func find(atHeureDebut heureDebut: NSDate) throws -> Evaluation? {
        self.request.predicate = NSPredicate(format: "pheureDebut == %@", heureDebut)
        do{
            let result = try CoreDataManager.context.fetch(request) as [Evaluation]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    
    // MARK: - Update function
    
    func update(anEvaluation evaluation: Evaluation) -> Evaluation {
        CoreDataManager.save()
        return evaluation
    }
    
    
    // MARK: - Delete function
    
    func delete(anEvaluation evaluation: Evaluation) {
        CoreDataManager.context.delete(evaluation)
        CoreDataManager.save()
    }
}
