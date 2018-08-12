//
//  MenuParentInfoHeaderView.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 07/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class MenuParentInfoHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        self.imgView.layer.cornerRadius = self.imgView.bounds.size.width/2.0
        self.imgView.clipsToBounds = true
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
