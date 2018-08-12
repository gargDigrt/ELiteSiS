//
//  DateExtension.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

extension Date{
    
    
    /// This method is used to get the current date with specified format default is 09-Mar-1990
    ///
    /// - Parameter format: i.e. dd-MMM-yyyy
    /// - Returns: formatted date string
    static func getCurrentDateWithFormat(format: String = "dd-MMM-yyyy")->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date())
    }
}
