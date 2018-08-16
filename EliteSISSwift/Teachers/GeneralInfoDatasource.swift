//
//  GeneralInfoDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol GeneralInfoDelegate: class {
    func calendarClicked()
}


class GeneralInfoDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    weak var delegate: GeneralInfoDelegate?
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        
        isDetailEditable = editable
    }
    
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
            if(profileData["Gender"] == "1"){
                cell.textField.text = "Male"
            }
            else if(profileData["Gender"] == "2"){
                cell.textField.text = "Female"
            }
            else if (profileData["Gender"] == "3"){
                cell.textField.text = "Others"
            }
            cell.textField.placeholder = "Gender"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.textField.isEnabled = isDetailEditable
            cell.isUserInteractionEnabled = isDetailEditable

            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionTableViewCell") as! DateSelectionTableViewCell
            cell.selectionStyle = .none
            
            let fullDate: String? = profileData["DateOfBirth"]
            let fullDateArr = fullDate?.components(separatedBy: "T")
            let requiredDate : String? = fullDateArr?[0]
            cell.lblDate.text = requiredDate
            cell.backgroundColor = UIColor.clear
            cell.delegate = self
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.text = profileData["FatherName"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.textField.isEnabled = isDetailEditable
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter your Mother's name"
            cell.textField.text = profileData["MotherName"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.textField.isEnabled = isDetailEditable
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            if(profileData["Category"] == "1"){
            cell.textField.text = "BPL"
            }
            else if(profileData["Category"] == "2"){
                cell.textField.text = "APL"
            }
            else if (profileData["Category"] == "3"){
                cell.textField.text = "EPL"
            }
            
            
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.textField.isEnabled = isDetailEditable
            cell.isUserInteractionEnabled = isDetailEditable

            return cell
            
        default:
            return UITableViewCell()
        }
        
        
    }
    
}

extension GeneralInfoDatasource: DateSelectionCellProtocol{
    func calendarClicked() {
        self.delegate?.calendarClicked()
    }
}
