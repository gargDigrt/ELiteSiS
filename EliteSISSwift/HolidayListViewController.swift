//
//  HolidayListViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Holiday {
    var name: String
    var date: Date
    var day: String
    
    init(name: String, date: String, day: String) {
        self.name = name
        self.day = day
        let holidayDate = Date.convertSringToDate(dateString: date)
        self.date = holidayDate!
    }
    
}

class HolidayListViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var tblViewHolidayList: UITableView!
    
    //Variable
    var arrHolidayList = [Holiday]()
    
    
    //MARK:- View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTableView()
        self.getHolidayList()
    }
    
    // MARK: - Button Actions
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        //destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
        let selectedLogin=UserDefaults.standard.string(forKey: "selectedLogin")
        if (selectedLogin == "S"){
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
            sideMenuController()?.setContentViewController(destViewController)
            
        }
        else if(selectedLogin == "E"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        else if(selectedLogin == "G"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
    
    
    // MARK: - Custom methods
    
    fileprivate func configureTableView() {
        
        tblViewHolidayList.separatorStyle = .none
        tblViewHolidayList.sectionHeaderHeight = 45
        tblViewHolidayList.rowHeight = UITableViewAutomaticDimension
        self.tblViewHolidayList.delegate = self
        self.tblViewHolidayList.dataSource = self
        self.tblViewHolidayList.register(UINib(nibName:"HolidaylistHeaderReusableviewTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HolidaylistHeaderReusableviewTableViewCell")
        self.tblViewHolidayList.register(UINib(nibName:"HolidayListTableViewCell", bundle:nil), forCellReuseIdentifier: "HolidayListTableViewCell")
    }
    
    func getHolidayList() {
        ProgressLoader.shared.showLoader(withText: "")
        WebServices.shared.getHolidayList(completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                let arrHolidayData = responseDict["value"].arrayValue
                for holidayData in arrHolidayData {
                    let name = holidayData["sis_name"].stringValue
                    let date = holidayData["new_startdate"].stringValue
                    let day = holidayData["new_dayname"].stringValue
                    let holiday = Holiday(name: name, date: date, day: day)
                    self.arrHolidayList.append(holiday)
                }
                self.arrHolidayList = self.arrHolidayList.sorted(by: { $0.date < $1.date })
                DispatchQueue.main.async {
                    self.tblViewHolidayList.reloadData()
                    ProgressLoader.shared.hideLoader()
                }
            }
            else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error Occured!", message: "Please try after some time")
                debugPrint(error?.localizedDescription ?? "Getting Holiday list error")
            }
        })
        
    }
    
}

//MARK:- UITableView Delegate & DAtasource

extension HolidayListViewController:  UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrHolidayList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HolidaylistHeaderReusableviewTableViewCell") as! HolidaylistHeaderReusableviewTableViewCell
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayListTableViewCell") as! HolidayListTableViewCell
//        print(self.arrHolidayList[indexPath.row]["sis_name"] as Any)
        
        cell.configureCell(data: arrHolidayList[indexPath.row])
        return cell
    }
    
}

