//
//  EventCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.addShadowForView(myView: self)
    }

    func config(eventName: String, color: UIColor){
        lblEventName.text = eventName
        viewContent.backgroundColor = color
    }
    
    private func addShadowForView(myView: UIView){
        myView.layer.cornerRadius = 10
        myView.clipsToBounds = true
        myView.layer.shadowPath = UIBezierPath(roundedRect:
            myView.bounds, cornerRadius: myView.layer.cornerRadius).cgPath
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = 0.3
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 5
        myView.layer.masksToBounds = false
    }
}
