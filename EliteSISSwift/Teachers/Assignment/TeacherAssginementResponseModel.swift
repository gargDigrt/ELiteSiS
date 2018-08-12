//
//  TeacherAssginementResponseModel.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 19/05/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

enum ASSIGNMENT_STATUS{
    case COMPLETED
    case NOT_COMPLETED
}

struct TeacherAssginementResponseModel{
    var description: String!
    var issueDate: String!
    var endDate: String!
    var status: ASSIGNMENT_STATUS!
    
    func getDummyData()->[TeacherAssginementResponseModel]{
        
        var model = [TeacherAssginementResponseModel]()
        model.append(TeacherAssginementResponseModel(description: "Assignment 1", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .COMPLETED))
        model.append(TeacherAssginementResponseModel(description: "Assignment 2", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .COMPLETED))
        model.append(TeacherAssginementResponseModel(description: "Assignment 3", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .COMPLETED))
        model.append(TeacherAssginementResponseModel(description: "Assignment 4", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .NOT_COMPLETED))
        model.append(TeacherAssginementResponseModel(description: "Assignment 5", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .NOT_COMPLETED))
        model.append(TeacherAssginementResponseModel(description: "Assignment 6", issueDate: "24-Jan-2017", endDate: "28-Jan-2017", status: .NOT_COMPLETED))
        
        return model
    }
}
