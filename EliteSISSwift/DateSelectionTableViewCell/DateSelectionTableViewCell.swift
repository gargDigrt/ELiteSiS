//
//  DateSelectionTableViewCell.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 06/05/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol DateSelectionCellProtocol: class {
    func calendarClicked()
}

class DateSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    weak var delegate: DateSelectionCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCalendarClick(_ sender: Any) {
        self.delegate?.calendarClicked()
    }
}
