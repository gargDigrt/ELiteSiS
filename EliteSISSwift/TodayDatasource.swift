//
//  TodayDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 06/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TodayDatasource: NSObject, UITableViewDataSource {
    
    var arrTodayClass = [String]()
    var arrTodayTeacher = [String]()
    var arrTodayAssignment = [String]()
    var arrDate = [String]()
    
    func configureData() {
        arrTodayClass.append("Class 9th")
        arrTodayClass.append("Class 9th")
        arrTodayClass.append("Class 9th")
        
        arrTodayTeacher.append("Miss Santos")
        arrTodayTeacher.append("Miss Santos")
        arrTodayTeacher.append("Miss Santos")
        
        arrTodayAssignment.append("Assignment in Geography")
        arrTodayAssignment.append("Assignment in Geography")
        arrTodayAssignment.append("Assignment in Geography")
        
        arrDate.append("now")
        arrDate.append("now")
        arrDate.append("now")
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
