//
//  StudentAddressDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class StudentAddressDatasource: NSObject, UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Address Detail"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_houseno") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "Address"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the address type"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_addresssubtype") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "Address Type"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the city"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_city") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "City"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the state"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_state") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "State"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the country"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_country") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "Country"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the postal code"
            cell.textField.text = UserDefaults.standard.object(forKey: "sis_postalcode") as? String
            cell.textField.isUserInteractionEnabled = false
            cell.titleLabel.text = "Postal Code"
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
}
