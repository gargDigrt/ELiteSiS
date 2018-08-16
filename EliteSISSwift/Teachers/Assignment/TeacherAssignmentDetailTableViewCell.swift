//
//  TeacherAssignmentDetailTableViewCell
//  EliteSISSwift
//
//  Created by PeakGeek on 05/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TeacherAssignmentDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAssignmentName: UILabel!
    @IBOutlet weak var lblIssueDate: UILabel!
    @IBOutlet weak var lblSubmitDate: UILabel!
    @IBOutlet weak var imgViewStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(assignmentType: TEACHER_ASSIGNMENT_TYPE, dataSource: TeacherAssginementResponseModel){
        
        self.imgViewStatus.image = dataSource.status == .COMPLETED ? #imageLiteral(resourceName: "ic_done.png") : #imageLiteral(resourceName: "delete-sign.png")
        self.lblAssignmentName.text = dataSource.description
        self.lblIssueDate.text = dataSource.issueDate
        self.lblSubmitDate.text = dataSource.endDate
        
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
