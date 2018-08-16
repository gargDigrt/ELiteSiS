//
//  HolidayListTableViewCell.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class HolidayListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHolidayName: UILabel!
    @IBOutlet weak var lblHolidayDate: UILabel!
    @IBOutlet weak var lblHolidayDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
