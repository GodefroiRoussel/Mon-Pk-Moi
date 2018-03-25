//
//  AvisExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 25/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension Avis {
    /// firstname of Person
    public var commentaire : String?{
        get{
            return self.pcommentaire
        }
        set{
            self.pcommentaire = newValue
        }
    }
    
    public var choix : Bool{
        get{
            return self.pchoix
        }
        set{
            self.pchoix = newValue
        }
    }
    
    convenience init(withChoix choix: Bool, withCommentaire commentaire: String?, belongs_to traceur: Traceur, is_a typeAvis: TypeAvis){
        self.init(context: CoreDataManager.context)
        self.pchoix = choix
        self.pcommentaire = commentaire
        self.belongs_to = traceur
        self.is_a = typeAvis
    }
}
