//
//  ComplaintsListTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 14/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ComplaintsListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblParent: UILabel!
    
    @IBOutlet weak var lblStudent: UILabel!
    
    @IBOutlet weak var lblSubject: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
