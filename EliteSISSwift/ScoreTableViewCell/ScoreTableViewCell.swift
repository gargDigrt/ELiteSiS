//
//  ScoreTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 04/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMarks: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
