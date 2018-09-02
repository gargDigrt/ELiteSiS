//
//  TodayDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 06/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class TodayDatasource: NSObject, UITableViewDataSource {
    
    var arrTodayClass = [String]()
    var arrTodayTeacher = [String]()
    var arrTodayAssignment = [String]()
    var arrDate = [String]()
    
    func configureData(from json: [JSON] ) {
        for item in json {
            let heading = item["new_heading"].stringValue
            arrTodayClass.append(heading)
            let title = item["new_title"].stringValue
            arrTodayTeacher.append(title)
            var crationDate = item["createdon"].stringValue
            crationDate = Date.getFormattedDate(string: crationDate, formatter: "dd-MMM")
            arrDate.append(crationDate)
            let desc = item["new_description"].stringValue
            arrTodayAssignment.append(desc)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTodayClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
        cell.lblClass.text = arrTodayClass[indexPath.row]
        cell.lblClass.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.lblName.text = arrTodayTeacher[indexPath.row]
        cell.lblName.font = UIFont.systemFont(ofSize: 15)
        cell.lblName.textColor = UIColor.darkGray
        
        cell.lblAssignment.text = arrTodayAssignment[indexPath.row]
        cell.lblAssignment.font = UIFont.systemFont(ofSize: 15)
        cell.lblAssignment.textColor = UIColor.darkGray
        
        cell.lblDate.text = arrDate[indexPath.row]
        cell.lblDate.font = UIFont.systemFont(ofSize: 15)
        cell.lblDate.textColor = UIColor.darkGray
        
        return cell
    }

}
