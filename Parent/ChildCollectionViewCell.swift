//
//  ChildCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 19/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChildCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imgViewChild: UIImageView!
    @IBOutlet weak var lblChildName: UILabel!
    @IBOutlet weak var lblChildClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgViewChild.layer.cornerRadius = self.imgViewChild.bounds.width/2.0
        self.imgViewChild.clipsToBounds = true
    }
    
    func config(model: ChildViewDataModel){
        self.imgViewChild.image = UIImage(named: model.imgName)
        self.lblChildName.text = model.name
        self.lblChildClass.text = model.className
    }

}

