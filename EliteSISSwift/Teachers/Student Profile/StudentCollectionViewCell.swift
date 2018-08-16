//
//  StudentCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 07/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func Config(data: StudentAttendanceViewModel){
        
        lblName.text = data.name
        imgView.image = UIImage(named: data.imgName)
    }
}
