//
//  MissedDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 06/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class MissedDatasource: NSObject, UITableViewDataSource {
    
    var arrMissedClass = [String]()
    var arrMissedTeacher = [String]()
    var arrMissedAssignment = [String]()
    var arrDate = [String]()
    
    func configureData() {
        arrMissedClass.append("Class 9th")
        arrMissedClass.append("Class 9th")
        arrMissedClass.append("Class 9th")
        
        arrMissedTeacher.append("Miss Santos")
        arrMissedTeacher.append("Miss Santos")
        arrMissedTeacher.append("Miss Santos")
        
        arrMissedAssignment.append("Assignment in Geography")
        arrMissedAssignment.append("Assignment in Geography")
        arrMissedAssignment.append("Assignment in Geography")
        
        arrDate.append("5 days ago")
        arrDate.append("5 days ago")
        arrDate.append("5 days ago")
    }
    
    
    func configureData(from json: [JSON] ) {
        for item in json {
            let heading = item["new_heading"].stringValue
            arrMissedClass.append(heading)
            let title = item["new_title"].stringValue
            arrMissedTeacher.append(title)
            var crationDate = item["createdon"].stringValue
            crationDate = Date.getFormattedDate(string: crationDate, formatter: "dd-MMM")
            arrDate.append(crationDate)
            let desc = item["new_description"].stringValue
            arrMissedAssignment.append(desc)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMissedClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
        cell.lblClass.text = arrMissedClass[indexPath.row]
        cell.lblClass.font = UIFont.boldSystemFont(ofSize: 18)
        cell.lblClass.textColor = UIColor.red
        
        cell.lblName.text = arrMissedTeacher[indexPath.row]
        cell.lblName.font = UIFont.systemFont(ofSize: 15)
        cell.lblName.textColor = UIColor.darkGray
        cell.lblName.textColor = UIColor.red
        
        cell.lblAssignment.text = arrMissedAssignment[indexPath.row]
        cell.lblAssignment.font = UIFont.systemFont(ofSize: 15)
        cell.lblAssignment.textColor = UIColor.darkGray
        cell.lblAssignment.textColor = UIColor.red
        
        cell.lblDate.text = arrDate[indexPath.row]
        cell.lblDate.font = UIFont.systemFont(ofSize: 15)
        cell.lblDate.textColor = UIColor.darkGray
        cell.lblDate.textColor = UIColor.red
        return cell
    }

}
