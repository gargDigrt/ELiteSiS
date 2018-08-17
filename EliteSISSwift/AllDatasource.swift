//
//  AllDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 06/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class AllDatasource: NSObject, UITableViewDataSource {
    
    var arrAllClass = [String]()
    var arrAllEvent = [String]()
    var arrAllTiming = [String]()
    var arrDate = [String]()
    
    func configureData() {
        arrAllClass.append("Class 12th")
        arrAllClass.append("Class 10th")
        
        arrAllEvent.append("Parade")
        arrAllEvent.append("Awards")
        
        arrAllTiming.append("26th January Timing 11:00 AM. All parents are invited.")
        arrAllTiming.append("26th January Timing 11:00 AM. All parents are invited.")
        
        arrDate.append("26-Jan-2018")
        arrDate.append("26-Jan-2018")
        
    }
    
     func configureData(from json: [JSON] ) {
        for item in json {
            let heading = item["new_heading"].stringValue
            arrAllClass.append(heading)
            let title = item["new_title"].stringValue
            arrAllEvent.append(title)
            var crationDate = item["createdon"].stringValue
            crationDate = Date.getFormattedDate(string: crationDate, formatter: "MMM dd")
            arrDate.append(crationDate)
            let desc = item["new_description"].stringValue
            arrAllTiming.append(desc)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAllClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as! NotificationTableViewCell
        cell.selectionStyle = .none
        cell.lblClass.text = arrAllClass[indexPath.row]
        cell.lblClass.font = UIFont.boldSystemFont(ofSize: 18)
        
        cell.lblName.text = arrAllEvent[indexPath.row]
        cell.lblName.font = UIFont.systemFont(ofSize: 15)
        cell.lblName.textColor = UIColor.darkGray
        
        cell.lblAssignment.text = arrAllTiming[indexPath.row]
        cell.lblAssignment.font = UIFont.systemFont(ofSize: 15)
        cell.lblAssignment.textColor = UIColor.darkGray
        
        cell.lblDate.text = arrDate[indexPath.row]
        cell.lblDate.font = UIFont.systemFont(ofSize: 15)
        cell.lblDate.textColor = UIColor.darkGray
        
        return cell
    }

}
