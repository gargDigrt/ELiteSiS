//
//  TextFieldWithCalendarTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TextFieldWithCalendarTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textfield.delegate = self
        // Initialization code
    }
    
    override func prepareForReuse() {
        textfield.text = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
