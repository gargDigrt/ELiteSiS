//
//  ReceiverTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 27/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {

    @IBOutlet weak var lblMsg: ChatLabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
//        lblMsg.backgroundColor = UIColor.white
//        lblMsg.layer.borderWidth = 1.0
//        lblMsg.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
