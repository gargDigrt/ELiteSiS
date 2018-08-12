//
//  FeeReminderTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var viewFeeProgress: KDCircularProgress!
    @IBOutlet weak var lblFeeDuration: UILabel!
    @IBOutlet weak var lblFeeTitle: UILabel!
    @IBOutlet weak var lblFeeProgress: UILabel!
    
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
        
        self.viewFeeProgress.animate(toAngle: self.newAngle(data.assignmentProgressPercent), duration: 1.0, completion: nil)
    }
    
    func newAngle(_ currentCount:Double) -> Double {
        let maxCount = 100.0
        return 360 * (currentCount / maxCount)
    }
}
