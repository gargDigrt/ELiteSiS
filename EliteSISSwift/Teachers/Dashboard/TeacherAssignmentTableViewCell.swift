//
//  AssignmentTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TeacherAssignmentTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var viewProgress: KDCircularProgress!
    @IBOutlet weak var lblProgressPercent: UILabel!
    @IBOutlet weak var viewAssignment: KDCircularProgress!
    @IBOutlet weak var lblAssignmentPercent: UILabel!
    @IBOutlet weak var lblClassName: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewInner.layer.cornerRadius = 8.0
        self.viewInner.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(data: AssignmentViewDataModel){
        self.viewProgress.animate(toAngle: self.newAngle(data.workProgressPercent), duration: 1.0, completion: nil)
        self.lblProgressPercent.text = "\(data.workProgressPercent!)%"
        
        self.viewAssignment.animate(toAngle: self.newAngle(data.assignmentProgressPercent), duration: 1.0, completion: nil)
        self.lblAssignmentPercent.text = "\(data.assignmentProgressPercent!)%"
        
        self.lblSubject.text = data.subjectName
        self.lblClassName.text = data.className
    }
    
    func config(data: Dictionary<String, Any>){
        self.viewProgress.animate(toAngle: self.newAngle(data["Studyprogress"] as! Double), duration: 1.0, completion: nil)
        self.lblProgressPercent.text = "\(data["Studyprogress"] as! Double)%"
        
        self.viewAssignment.animate(toAngle: self.newAngle(data["Studyprogress"] as! Double), duration: 1.0, completion: nil)
        self.lblAssignmentPercent.text = "\(data["Studyprogress"] as! Double)%"
        
        self.lblSubject.text = data["SubjectName"] as! String
        self.lblClassName.text = data["sectionName"] as! String
    }
    
    func newAngle(_ currentCount:Double) -> Double {
        let maxCount = 100.0
        return 360 * (currentCount / maxCount)
    }
}
