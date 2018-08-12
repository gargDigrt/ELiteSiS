//
//  IdentityCardDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class IdentityCardDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        
        isDetailEditable = editable
    }
    
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
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card number"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldwithCalendarTableCell") as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = "Enter the issued data"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldwithCalendarTableCell") as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = "Enter the expiry date"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the licensing authority"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the card description"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the id for"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
