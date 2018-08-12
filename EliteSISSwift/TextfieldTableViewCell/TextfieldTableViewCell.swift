//
//  TextfieldTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TextfieldTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }
    
    override func prepareForReuse() {
        textField.text = nil
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
