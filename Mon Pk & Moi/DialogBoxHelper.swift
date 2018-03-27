//
//  DialogBoxHelper.swift
//  Mon Pk & Moi
//
//  Created by Godefroi Roussel on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

/**
 DialogBoxHelper type
 
 Functions :
 - alert(String, String, UIViewController) => show an alert dialog box with two message on a view.
 - alert(NSError, UIViewController) => show an alert dialog box with two error message on a view.
 */
class DialogBoxHelper{
    
    /// Show an alert dialog box with two message
    ///
    /// - Parameters:
    ///   - title: Title of the error
    ///   - msg: Message of the error
    ///   - view: The UIViewController where to present the alert
    static func alert(withTitle title: String, andMessage msg: String = "", onView view: UIViewController){
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style : .default)
        alert.addAction(cancelAction)
        view.present(alert,animated: true)
    }
    
    
    /// Shows an alert to inform about an error
    ///
    /// - Parameters:
    ///   - error: error we want information about
    ///   - view: The UIViewController where to present the alert
    static func alert(onError error: NSError, onView view: UIViewController){
        self.alert(withTitle: "\(error)", andMessage: "\(error.userInfo)", onView: view)
    }
    
}
