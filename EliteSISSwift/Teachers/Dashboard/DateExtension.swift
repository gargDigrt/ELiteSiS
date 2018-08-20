//
//  DateExtension.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

extension Date{
    
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
        let date: Date? = dateFormatterGet.date(from: string)
        //        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
    
    static func convertSringToDate(dateString: String)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let dateFromString: Date? = dateFormatter.date(from: dateString)
        guard let dateValue = dateFromString else {
            return nil
        }
        return dateValue
    }
    
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
