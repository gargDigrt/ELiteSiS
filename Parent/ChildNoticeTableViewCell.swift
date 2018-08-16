//
//  ChildNoticeTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChildNoticeTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var lblParentFullName: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblNoticeDate: UILabel!
    @IBOutlet weak var viewNameSort: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewInner.layer.cornerRadius = 8.0
        self.viewInner.layer.masksToBounds = true
        
        self.viewNameSort.layer.cornerRadius = self.viewNameSort.bounds.size.width/2.0
        self.viewNameSort.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(data: AssignmentViewDataModel){
      
    }
}
