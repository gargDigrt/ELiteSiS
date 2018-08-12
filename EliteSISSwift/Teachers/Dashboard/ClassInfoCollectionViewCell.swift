//
//  ClassInfoCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 31/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ClassInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblClassNumber: UILabel!
    @IBOutlet weak var lblClassTiming: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblClassName: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(data: ClassViewDataModel){
        lblClassNumber.text = data.classNumber
        lblClassTiming.text = data.classTiming
        lblSubject.text = "\(data.subject!)-"
        lblChapter.text = data.chapter
        lblClassName.text = data.className
        
        if data.subject.capitalized == "free".capitalized{
            self.viewContent.backgroundColor = UIColor.yellow
        }
    }
}
