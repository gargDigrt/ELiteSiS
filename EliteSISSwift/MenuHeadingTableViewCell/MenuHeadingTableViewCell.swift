//
//  MenuHeadingTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 21/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class MenuHeadingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewStudentWidth: NSLayoutConstraint!
    @IBOutlet weak var imgViewStudent: UIImageView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblParentName: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewStudent.layer.cornerRadius = imgViewStudentWidth.constant/2
        imgViewStudent.backgroundColor = UIColor.red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
