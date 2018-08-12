//
//  FeeViewModel.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 22/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit


struct FeeViewModel {
    var headerTitle : String
    var cellH1Text  : String
    var cellH2Text  : String
    var cellH3Text  : String
    var cellType : FeeCellType
    var items : [FeeItemModel]
}


struct FeeItemModel{
    var count: String
    var cellItem1: String
    var cellItem2: String
    var cellItem3: String
}
