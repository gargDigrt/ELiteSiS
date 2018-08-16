//
//  ButtonWithBgTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol LoginButtonDelegate: class {
    func buttonClicked()
}

class ButtonWithBgTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    weak var delegate: LoginButtonDelegate?
    
    @IBOutlet weak var btnInCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnInCell.addTarget(self, action: #selector(ButtonWithBgTableViewCell.btnClicked), for: .touchUpInside)
    }
    
    @objc func btnClicked() {
        delegate?.buttonClicked()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
