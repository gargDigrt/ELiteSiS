//
//  ButtonWithBgTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 19/02/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

protocol ProtocolButtonClickImplementation {
    func buttonClicked()
}

class ButtonWithBgTableViewCell: UITableViewCell,UITextFieldDelegate {
    var protocolButtonClickImplementation:ProtocolButtonClickImplementation?
    
    @IBOutlet weak var btnInCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnInCell.addTarget(self, action: #selector(ButtonWithBgTableViewCell.btnClicked), for: .touchUpInside)
    }
    
    @objc func btnClicked() {
        protocolButtonClickImplementation?.buttonClicked()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
