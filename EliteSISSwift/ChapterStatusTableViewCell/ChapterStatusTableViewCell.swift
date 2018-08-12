//
//  ChapterStatusTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChapterStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
