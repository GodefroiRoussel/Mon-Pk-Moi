//
//  NSDateExtension.swift
//  Mon Pk & Moi
//
//  Created by Melvil Donnart on 31/03/2018.
//  Copyright © 2018 romain. All rights reserved.
//

import Foundation

extension NSDate {
    func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self as Date).rawValue * self.compare(date2 as Date).rawValue >= 0
    }
}
