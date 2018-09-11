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

        data.append(EventViewDataModel(name: "Cultural", color: UIColor(red: 126/255.0, green: 242/255.0, blue: 168/255.0, alpha: 1.0)))
        data.append(EventViewDataModel(name: "Sports", color: UIColor(red: 205/255.0, green: 111/255.0, blue: 116/255.0, alpha: 1.0)))
//        data.append(EventViewDataModel(name: "Student Wellness Fair", color: UIColor(red: 61/255.0, green: 216/255.0, blue: 141/255.0, alpha: 1.0)))
//        data.append(EventViewDataModel(name: "Exams", color: UIColor.darkGray))

        return data
    }
}
