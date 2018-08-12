//
//  MenuStudentInfoHeaderView.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 21/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class MenuStudentInfoHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var imgViewStudentWidth: NSLayoutConstraint!
    @IBOutlet weak var imgViewStudent: UIImageView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblParentName: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    
    override func awakeFromNib() {
        
        imgViewStudent.layer.cornerRadius = imgViewStudentWidth.constant/2
       
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
