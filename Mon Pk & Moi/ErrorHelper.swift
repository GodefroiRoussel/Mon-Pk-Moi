//
//  ErrorHelper.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 16/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import UIKit

/**
 ErrorHelper type
 
 **alertError(String, String) => show an alert dialog box with two message
 */
class ErrorHelper{
    
    /// Show an alert dialog box with two message
    ///
    /// - Parameters:
    ///   - title: Title of the error
    ///   - msg: Message of the error
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
    /// - Parameter error: error we want information about
    static func alert(onError error: NSError, onView view: UIViewController){
        self.alert(withTitle: "\(error)", andMessage: "\(error.userInfo)", onView: view)
    }
    
}
