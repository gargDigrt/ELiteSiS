//
//  StudentIdentityCardDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudentIdentityCardDatasource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Identity Card Details"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card type"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_identitycard") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card number"
             cell.textField.text = UserDefaults.standard.object(forKey: "sis_identityid") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldwithCalendarTableCell") as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = "Enter the issued date"
           // cell.textField.text = UserDefaults.standard.object(forKey: "sis_issuedon") as? String
            cell.textfield.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldwithCalendarTableCell") as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = "Enter the expiry date"
            cell.textfield.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the licensing authority"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_licensingauthority") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card description"
           cell.textField.text = UserDefaults.standard.object(forKey: "sis_description") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the id for"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_identity1") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
