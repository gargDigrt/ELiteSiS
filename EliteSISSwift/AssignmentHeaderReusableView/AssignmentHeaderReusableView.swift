//
//  AssignmentHeaderReusableView.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AssignmentHeaderReusableView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblSubmitDate: PaddingLabel!
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblIssueDate: PaddingLabel!
    @IBOutlet weak var lblAction: PaddingLabel!
    
    
    override func awakeFromNib() {
        
    }

}
