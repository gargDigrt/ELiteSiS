//
//  GalleryPhotosCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class GalleryPhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imgView.image = nil
        
    }

}
