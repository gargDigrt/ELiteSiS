//
//  StudentAttendanceViewModel.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 07/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation

struct StudentAttendanceViewModel {
    var name: String = ""
    var isPresent: Bool = false
    var imgName: String = ""
    
    func getDummyData()->[String : [StudentAttendanceViewModel]]{
        var dataSource: [String: [StudentAttendanceViewModel]] = [:]
        
        dataSource["4th"] = [
                            StudentAttendanceViewModel(name: "Kunal", isPresent: false, imgName: "ic_face_male.png"),
                            StudentAttendanceViewModel(name: "Hitesh", isPresent: false, imgName: "ic_face_male.png"),
                            StudentAttendanceViewModel(name: "Ramesh", isPresent: false, imgName: "ic_face_male.png"),
                            StudentAttendanceViewModel(name: "Suresh", isPresent: false, imgName: "ic_face_male.png"),
                            StudentAttendanceViewModel(name: "Kumar", isPresent: false, imgName: "ic_face_male.png")
                        ]
    
        dataSource["5th"] = [
                            StudentAttendanceViewModel(name: "Pinki", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Paarul", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Priya", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Preeti", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Kirti", isPresent: false, imgName: "ic_face_female.png")
                        ]

        dataSource["6th"] = [
                            StudentAttendanceViewModel(name: "Reetu", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Seetu", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Pinku", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Teetu", isPresent: false, imgName: "ic_face_female.png"),
                            StudentAttendanceViewModel(name: "Ram", isPresent: false, imgName: "ic_face_male.png")
        ]
        
        dataSource["7th"] = [
                           StudentAttendanceViewModel(name: "hhdh", isPresent: false, imgName: "ic_face_male.png"),
                           StudentAttendanceViewModel(name: "dhdhhd", isPresent: false, imgName: "ic_face_male.png"),
                           StudentAttendanceViewModel(name: "hdhdhdh", isPresent: false, imgName: "ic_face_female.png"),
                           StudentAttendanceViewModel(name: "dhhdhd", isPresent: false, imgName: "ic_face_male.png"),
                           StudentAttendanceViewModel(name: "ujdjdjjd", isPresent: false, imgName: "ic_face_female.png")
        ]

        return dataSource
    }
}
