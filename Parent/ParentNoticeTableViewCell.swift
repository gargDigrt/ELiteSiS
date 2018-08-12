//
//  ParentNoticeTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ParentNoticeTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var imgViewTeacher: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblNoticeDate: UILabel!
    
    
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
      
    }
}
