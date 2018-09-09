//
//  LoginCredentialsTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class LoginCredentialsTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var showHideBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.showHideBtn.isHidden = true
        
        textField.tintColor = UIColor.black
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 10
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        
        self.textField.isSecureTextEntry = sender.isSelected
        sender.isSelected = !sender.isSelected
        
    }
    
}
