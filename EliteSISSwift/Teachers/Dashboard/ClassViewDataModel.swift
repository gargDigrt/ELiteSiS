//
//  ClassViewDataModel.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

struct ClassViewDataModel{
    
    var classNumber: String!
    var classTiming: String!
    var subject: String!
    var chapter: String!
    var className: String!
    
    static func getDummyData()->[ClassViewDataModel] {
        var data = [ClassViewDataModel]()
        
        data.append(ClassViewDataModel(classNumber: "1", classTiming: "9:00-10:00", subject: "Science", chapter: "Chapter 1", className: "Class 6"))
        data.append(ClassViewDataModel(classNumber: "5", classTiming: "1:00-2:00", subject: "Maths", chapter: "Chapter 1", className: "Class 4"))
        data.append(ClassViewDataModel(classNumber: "2", classTiming: "10:00-11:00", subject: "Geog", chapter: "Chapter 1", className: "Class 8"))
        data.append(ClassViewDataModel(classNumber: "6", classTiming: "2:00-2:30", subject: "Geog", chapter: "Chapter 1", className: "Class 9"))
        data.append(ClassViewDataModel(classNumber: "3", classTiming: "11:00-12:00", subject: "Science", chapter: "Chapter 1", className: "Class 7"))
        data.append(ClassViewDataModel(classNumber: "7", classTiming: "2:30-3:00", subject: "Free", chapter: "", className: ""))
        data.append(ClassViewDataModel(classNumber: "4", classTiming: "12:00-1:00", subject: "Math", chapter: "Chapter 1", className: "Class 6"))
        data.append(ClassViewDataModel(classNumber: "8", classTiming: "3:00-4:00", subject: "History", chapter: "Chapter 1", className: "Class 8"))

        return data
    }
}
