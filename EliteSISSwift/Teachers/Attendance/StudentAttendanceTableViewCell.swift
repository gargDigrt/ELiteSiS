//
//  StudentAttendanceTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 06/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

enum CHECK_BOX_STATE: String{
    case CHECK = "\u{2713}"
    case UNCHECK = "\u{2610}"
}

class StudentAttendanceTableViewCell: UITableViewCell {
    @IBOutlet weak var lblCheckBoxAbsent: UILabel!
    @IBOutlet weak var lblCheckBoxPresent: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblCheckBoxAbsent.text = CHECK_BOX_STATE.UNCHECK.rawValue
        lblCheckBoxPresent.text = CHECK_BOX_STATE.UNCHECK.rawValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(studentData: StudentAttendanceViewModel){
        lblName.text = studentData.name
        
        if studentData.isPresent{
            lblCheckBoxPresent.text = CHECK_BOX_STATE.CHECK.rawValue
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.UNCHECK.rawValue
        }
        else{
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.CHECK.rawValue
            lblCheckBoxPresent.text = CHECK_BOX_STATE.UNCHECK.rawValue
        }
    }
    
    @IBAction func checkboxAbsentTapped(_ sender: Any) {
        if lblCheckBoxAbsent.text! == CHECK_BOX_STATE.UNCHECK.rawValue && lblCheckBoxPresent.text! == CHECK_BOX_STATE.CHECK.rawValue{
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.CHECK.rawValue
            lblCheckBoxPresent.text = CHECK_BOX_STATE.UNCHECK.rawValue
            
            return
        }
        
        if lblCheckBoxPresent.text! == CHECK_BOX_STATE.UNCHECK.rawValue && lblCheckBoxAbsent.text! == CHECK_BOX_STATE.UNCHECK.rawValue{
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.CHECK.rawValue
            
            return
        }
        
        if lblCheckBoxPresent.text! == CHECK_BOX_STATE.CHECK.rawValue && lblCheckBoxAbsent.text! == CHECK_BOX_STATE.UNCHECK.rawValue{
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.UNCHECK.rawValue

            return
        }
    }
    @IBAction func checkboxPresentTapped(_ sender: Any) {
        if lblCheckBoxPresent.text! == CHECK_BOX_STATE.UNCHECK.rawValue && lblCheckBoxAbsent.text! == CHECK_BOX_STATE.CHECK.rawValue{
            lblCheckBoxPresent.text = CHECK_BOX_STATE.CHECK.rawValue
            lblCheckBoxAbsent.text = CHECK_BOX_STATE.UNCHECK.rawValue
            
            return
        }
        
        if lblCheckBoxPresent.text! == CHECK_BOX_STATE.UNCHECK.rawValue && lblCheckBoxAbsent.text! == CHECK_BOX_STATE.UNCHECK.rawValue{
            lblCheckBoxPresent.text = CHECK_BOX_STATE.CHECK.rawValue
            
            return
        }
        
        if lblCheckBoxPresent.text! == CHECK_BOX_STATE.CHECK.rawValue && lblCheckBoxAbsent.text! == CHECK_BOX_STATE.UNCHECK.rawValue{
            lblCheckBoxPresent.text = CHECK_BOX_STATE.UNCHECK.rawValue
            
            return
        }
    }
    
}
