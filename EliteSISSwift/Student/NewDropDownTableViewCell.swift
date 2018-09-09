//
//  NewDropDownTableViewCell.swift
//  EliteSISSwift
//
//  Created by VEERU KATIYAR on 9/4/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class NewDropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var DropDownBtnOutlet: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
