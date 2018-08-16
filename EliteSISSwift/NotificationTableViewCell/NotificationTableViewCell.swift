//
//  NotificationTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 07/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAssignment: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
