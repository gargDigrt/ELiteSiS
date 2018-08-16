//
//  AssignmentTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class EventNoticeTableViewCell: UITableViewCell {
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var lblClassName: UILabel!
    @IBOutlet weak var lblEventDesc: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    
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
