//
//  GalleryCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 27/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = floor(((UIScreen.main.bounds.width - 70)/3))/2
        imgView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        lblText.text = nil
    }

}
