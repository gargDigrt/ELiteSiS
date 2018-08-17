//
//  AssignmentTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnViewAssignment: UIButton!
    @IBOutlet weak var btnDownloadAssignment: UIButton!
    @IBOutlet weak var lblSubmitDate: PaddingLabel!
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblIssueDate: PaddingLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayData(dict: Assignment) {
        if let _ = dict.id {
            
        }
        if let _ = dict.description {

        }
        if let submitDat = dict.submitDate {
            lblSubmitDate.text = submitDat
        }
        if let duedate = dict.dueDate {
            lblIssueDate.text = duedate
        }
        if let name = dict.name {
            lblDescription.text = name
        }
        if let _ = dict.status {
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
