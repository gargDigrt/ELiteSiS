//
//  UpcomingPinboardDataSource.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 16/03/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class UpcomingPinboardDataSource: NSObject, UITableViewDataSource {
    
    var arrAllClass = [String]()
    var arrAllEvent = [String]()
    var arrAllTiming = [String]()
    var arrDate = [String]()
    
    func configureData() {
        arrAllClass.append("Class 12th")
        arrAllClass.append("Class 10th")
        
        arrAllEvent.append("Sports Meet")
        arrAllEvent.append("Awards")
        
        arrAllTiming.append("26th April; Timing 11:00 AM. All parents are invited.")
        arrAllTiming.append("28th April Timing 11:00 AM. All parents are invited.")
        
        arrDate.append("26-April-2018")
        arrDate.append("28-April-2018")
        
        
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
