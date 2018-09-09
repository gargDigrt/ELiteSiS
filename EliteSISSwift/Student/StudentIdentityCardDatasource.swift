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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Identity Card Detail"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card type"
           // cell.textField.text = UserDefaults.standard.object(forKey: "sis_identitycard") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.titleLabel.text = "Card Type"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card number"
             cell.textField.text = UserDefaults.standard.object(forKey: "sis_identity1") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.titleLabel.text = "Card Number"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionTableViewCell") as! DateSelectionTableViewCell
           
            cell.textLabel?.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
            
             let DateOfBirth = UserDefaults.standard.object(forKey: "sis_issuedon") as? String
           
            let Date = DateOfBirth?.split(separator: "T")
            let DOB = Date![0]
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let showDate = inputFormatter.date(from: String(DOB))
            inputFormatter.dateFormat = "dd-MMM-yyyy"
            let resultString = inputFormatter.string(from: showDate!)
            cell.lblDate.text = resultString
          
            cell.titleLabel.text = "Issue Date"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateSelectionTableViewCell") as! DateSelectionTableViewCell
            cell.textLabel?.text = "Enter the expiry date"
            cell.textLabel?.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           // cell.textfield.isUserInteractionEnabled = true
            cell.titleLabel.text = "Expiry Date"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the licensing authority"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_licensingauthority") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.titleLabel.text = "Licensing Authority"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card description"
           cell.textField.text = UserDefaults.standard.object(forKey: "sis_description") as? String
            cell.textField.isUserInteractionEnabled = true
            cell.titleLabel.text = "Card Description"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
//        case 7:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
//           // cell.textField.placeholder = "Enter the id for"
//            //cell.textField.text = UserDefaults.standard.object(forKey: "sis_identity1") as? String
////            cell.textField.isUserInteractionEnabled = true
////            cell.titleLabel.text = ""
//            cell.selectionStyle = .none
//            cell.backgroundColor = UIColor.clear
//            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
