//
//  AssignmentViewDataModel.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

struct AssignmentViewDataModel{
    
    var className: String!
    var subjectName: String!
    var workProgressPercent: Double!
    var assignmentProgressPercent: Double!
    
    func getDummyData()->[AssignmentViewDataModel]{
        var data = [AssignmentViewDataModel]()
        data.append(AssignmentViewDataModel(className: "5th", subjectName: "Science", workProgressPercent: 10, assignmentProgressPercent: 50))
        data.append(AssignmentViewDataModel(className: "6th", subjectName: "Math", workProgressPercent: 30, assignmentProgressPercent: 40))
        data.append(AssignmentViewDataModel(className: "3rd", subjectName: "English", workProgressPercent: 50, assignmentProgressPercent: 70))
        data.append(AssignmentViewDataModel(className: "2nd", subjectName: "Hindi", workProgressPercent: 90, assignmentProgressPercent: 60))
        data.append(AssignmentViewDataModel(className: "11th", subjectName: "Science", workProgressPercent: 55, assignmentProgressPercent: 33))
        data.append(AssignmentViewDataModel(className: "7th", subjectName: "Social", workProgressPercent: 66, assignmentProgressPercent: 80))

        
        return data
    }
}
