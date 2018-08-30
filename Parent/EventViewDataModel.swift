//
//  EventViewDataModel.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 19/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation
import UIKit

struct EventViewDataModel{
    var name: String!
    var color: UIColor!
    
    func getDummyData()->[EventViewDataModel]{
        var data: [EventViewDataModel] = []

        data.append(EventViewDataModel(name: "PTM", color: UIColor(red: 255/255.0, green: 221/255.0, blue: 75/255.0, alpha: 1.0)))
        data.append(EventViewDataModel(name: "Awards/Seminar", color: UIColor(red: 3/255.0, green: 147/255.0, blue: 247/255.0, alpha: 1.0)))
        data.append(EventViewDataModel(name: "Student Wellness Fair", color: UIColor(red: 61/255.0, green: 216/255.0, blue: 141/255.0, alpha: 1.0)))
        data.append(EventViewDataModel(name: "Exams", color: UIColor.darkGray))

        return data
    }
}
