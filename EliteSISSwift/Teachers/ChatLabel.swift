//
//  ChatLabel.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 27/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChatLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var insets : UIEdgeInsets!
    
    override func drawText(in rect: CGRect) {
        
        insets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        insets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        let width = ceil(superContentSize.width) + ceil(insets.left) + ceil(insets.right)
        let height = ceil(superContentSize.height) + ceil(insets.top) + ceil(insets.bottom)
        
        return CGSize(width: width , height: height)
    }

}
