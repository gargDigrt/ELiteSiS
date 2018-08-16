//
//  FeeItemsTableViewCell.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 22/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeItemsTableViewCell: UITableViewCell {
   
    @IBOutlet weak var cellCountLbl: UILabel!
    @IBOutlet weak var cellH1Lbl: UILabel!
    @IBOutlet weak var cellH2Lbl: UILabel!
    @IBOutlet weak var cellH3Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bindHeaderText(data:FeeItemModel, cellType: FeeCellType){
        self.cellCountLbl.text = data.count
        self.cellH1Lbl.text = data.cellItem1
        self.cellH2Lbl.text = data.cellItem2
        self.cellH3Lbl.text = data.cellItem3
        self.setH3LblColorForCell(type: cellType, value: data.cellItem3)
    }
    
    func setH3LblColorForCell(type:FeeCellType, value: String){
        if type == FeeCellType.Installments{
            var color: UIColor = UIColor.red
            if FeeStatusType(rawValue: value) == FeeStatusType.Clear{
                color = UIColor.green
            }
            self.cellH3Lbl.textColor = color
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
