//
//  StudentClassAppliedDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudentClassAppliedDatasource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Class Applied"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_registration") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.text = UserDefaults.standard.object(forKey: "_sis_class_value") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldwithCalendarTableCell") as! TextFieldWithCalendarTableViewCell
            let admiDate = UserDefaults.standard.object(forKey: "sis_dateofadmission") as? String
           
           
            let fullNameArr = admiDate?.split(separator: "T")
            let DOB = fullNameArr?[0].split(separator: "-")
           
            cell.textfield.text = "\(DOB![2])-\(DOB![1])-\(DOB![0])"
            cell.textfield.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
