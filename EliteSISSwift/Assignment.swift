//
//  Assignment.swift
//  EliteSISSwift
//
//  Created by Rigil on 17/08/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import Foundation
import SwiftyJSON

class Assignment {
    
    var id: String?
    var name: String?
    var dueDate: String?
    var submitDate: String?
    var description: String?
    var status: String?
    var value : String?
    
    init(json: JSON) {
        
        if let id = json["new_taskassignationid"].string {
            self.id = id
        }
        if let name = json["new_name"].string {
            self.name = name
        }
        if let duedate = json["new_duedate"].string {
            self.dueDate = Date.getFormattedDate(string: duedate, formatter: "MMM dd,yyyy")
        }
        if let new_submitdate = json["new_submitdate"].string {
            self.submitDate = Date.getFormattedDate(string: new_submitdate, formatter: "MMM dd,yyyy")
        }
        if let new_taskdescription = json["new_taskdescription"].string {
            self.description = new_taskdescription
        }
        if let new_taskstatus = json["new_taskstatus"].string {
            self.status = new_taskstatus
        }
        if let value = json["_new_taskassignment_value"].string {
            self.value = value
        }
        
    }
    
}

