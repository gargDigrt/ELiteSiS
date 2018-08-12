//
//  QualificationDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class QualificationDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        isDetailEditable = editable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell") as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Qualification Detail"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter your Qualification"
            cell.textField.text = profileData["QualificationName"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the year"
            cell.textField.text = profileData["Year"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "textfieldTableCell") as! TextfieldTableViewCell
            cell.textField.placeholder = "Enter the CGPA/Percentage"
            cell.textField.text = profileData["CGPA"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
