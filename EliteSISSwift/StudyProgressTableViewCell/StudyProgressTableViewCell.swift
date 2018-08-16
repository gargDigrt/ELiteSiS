//
//  StudyProgressTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 26/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudyProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var viewForVisibleCell: UIView!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var circularProgress: KDCircularProgress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewForVisibleCell.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
