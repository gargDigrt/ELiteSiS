//
//  StudentGeneralInfoDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudentGeneralInfoDatasource: NSObject, UITableViewDataSource {
    var studentName : String!
    weak var delegate: GeneralInfoDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "General Info"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            let genderId:String = UserDefaults.standard.value(forKey: "sis_gender") as! String
            if (genderId == "1") {
                cell.textField.text  = "MALE"
            } else if (genderId == "2") {
                cell.textField.text = "FEMALE"
            }
            else {
                cell.textField.text  = "Others"
            }
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionTableViewCell") as! DateSelectionTableViewCell
            
            let DateOfBirth = UserDefaults.standard.object(forKey: "sis_dateofbirth") as? String
           
            
            let fullNameArr = DateOfBirth?.split(separator: "T")
            let DOB = fullNameArr?[0].split(separator: "-")
           
           
            cell.textLabel?.text = "\(DOB![2])-\(DOB![1])-\(DOB![0])"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            if studentName != nil {
                cell.textField.text = studentName
                 
            }
            
            cell.textField.placeholder = "Enter your Father's name"
              cell.textField.text =  UserDefaults.standard.object(forKey: "sis_fathername") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter your Mother's name"
               cell.textField.text = UserDefaults.standard.object(forKey: "sis_mothername") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.text = "General"
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension StudentGeneralInfoDatasource: DateSelectionCellProtocol{
    func calendarClicked() {
        self.delegate?.calendarClicked()
    }
}

