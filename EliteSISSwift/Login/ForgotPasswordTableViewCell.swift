//
//  ForgotPasswordTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ForgotPasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var btnRememberMe: UIButton!
    @IBOutlet weak var lblRememberMe: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    var isRememberSelected:Bool!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnRememberMe.layer.borderWidth = 1
        btnRememberMe.layer.borderColor = UIColor.black.cgColor
        lblForgotPassword.text = "Forgot password?"
        lblRememberMe.text = "Remember me"
        lblForgotPassword.isUserInteractionEnabled = true
        lblRememberMe.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordTableViewCell.rememberMeClicked))
//        lblRememberMe.isUserInteractionEnabled = true
//        btnRememberMe.addTarget(self, action: #selector(ForgotPasswordTableViewCell.rememberMeClicked), for: .touchUpInside)
//        lblRememberMe.addGestureRecognizer(tapGesture)
    }
    
   
    
   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
