//
//  TeacherAssignmentHeaderFooterView.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 06/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TeacherAssignmentHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var lblSubmitDate: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func config(assignmentType: TEACHER_ASSIGNMENT_TYPE){
        switch assignmentType {
        case .ALL:
            lblIssueDate.isHidden = false
            lblSubmitDate.isHidden = false
        case .DUE:
            lblIssueDate.isHidden = false
            lblSubmitDate.isHidden = true
        case .SUBMITTED:
            lblIssueDate.isHidden = true
            lblSubmitDate.isHidden = false
        }
    }

}
