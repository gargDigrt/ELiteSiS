//
//  FeeInfoHeaderView.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 22/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeInfoHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var cellH1Lbl: UILabel!
    @IBOutlet weak var cellH2Lbl: UILabel!
    @IBOutlet weak var cellH3Lbl: UILabel!
    
    func bindHeaderText(h1: String?,h2: String?,h3: String?){
        self.cellH1Lbl.text = h1
        self.cellH2Lbl.text = h2
        self.cellH3Lbl.text = h3
    }
    override func awakeFromNib() {
        
    }

}
