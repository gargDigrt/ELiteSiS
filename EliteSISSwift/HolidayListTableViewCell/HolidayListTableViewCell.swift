//
//  HolidayListTableViewCell.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class HolidayListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHolidayName: UILabel!
    @IBOutlet weak var lblHolidayDate: UILabel!
    @IBOutlet weak var lblHolidayDay: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(data: Holiday) {
        
            self.lblHolidayName.text = data.name
        
            self.lblHolidayDate.text = changeDateFormat(date: data.date)
        
            self.lblHolidayDay.text = data.day
    }
    
    private func changeDateFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let dateObj = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "dd-MMM"
        let finalDateStr:String = dateFormatter.string(from: date)
        
        return finalDateStr
    }
    
}
