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

class HolidayListViewController: UIViewController {
    
    @IBOutlet weak var tblViewHolidayList: UITableView!
    var arrHolidayList = [[String: Any]]()
    
    
    //MARK:- View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        self .getHolidayList()
        // Do any additional setup after loading the view.
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
                self.arrHolidayList = responseDict["value"].arrayObject as! [[String : Any]]
                print(self.arrHolidayList)
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
        print(self.arrHolidayList[indexPath.row]["sis_name"] as Any)
        
        cell.configureCell(data: arrHolidayList[indexPath.row])
        return cell
    }
    
}

