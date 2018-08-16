//
//  ChildViewDataModel.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 19/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

struct ChildViewDataModel{
    var name: String!
    var imgName: String!
    var className: String!
    
    func getDummyData()->[ChildViewDataModel]{
        var data: [ChildViewDataModel] = []
        
        data.append(ChildViewDataModel(name: "Taarunsh Sarkar", imgName: "childpng.png", className: "Nursery"))
        data.append(ChildViewDataModel(name: "Taarunya Sarkar", imgName: "child2.jpeg", className: "K.G."))
        data.append(ChildViewDataModel(name: "Taaruni Sarkar", imgName: "child1.jpeg", className: "2nd"))
        data.append(ChildViewDataModel(name: "Taarang Sarkar", imgName: "childpng.png", className: "4th"))

        return data
    }
}
