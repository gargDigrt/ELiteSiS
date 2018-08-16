//
//  FeeDefaulterTableViewCell.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 03/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeDefaulterTableViewCell: UITableViewCell {
    @IBOutlet weak var lblFeeName: UILabel!
    @IBOutlet weak var lblFeeClass: UILabel!
    @IBOutlet weak var lblFeeDueAmount: UILabel!
    @IBOutlet weak var lblFeeDueDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

