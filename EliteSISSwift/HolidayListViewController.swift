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
import ALLoadingView

class HolidayListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewHolidayList: UITableView!
    var arrHolidayName = [String]()
    var arrHolidayDate = [String]()
    var arrHolidayDay = [String]()
    var arrHolidayList = [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewHolidayList.separatorStyle = .none
        tblViewHolidayList.sectionHeaderHeight = 45
        tblViewHolidayList.rowHeight = UITableViewAutomaticDimension
       
//        arrHolidayName = ["Republic Day","Maha Shivratri","Holika Dahan","Holi","Ram Navami","Rakshabandhan","Dussehra","Chhoti Diwali","Badi Diwali","Christmas"]
//        arrHolidayDate = ["26-Jan-2018", "13-Feb-2018", "01-Mar-2018", "02-Mar-2018", "25-Mar-2018", "26-Aug-2018","19-Oct-2018", "06-Nov-2018", "07-Nov-2018", "25-Dec-2018"]
//        arrHolidayDay = ["Friday", "Tuesday", "Thursday", "Friday", "Sunday", "Sunday","Friday", "Tuesday", "Wednesday", "Monday"]
        self.tblViewHolidayList.delegate = self
        self.tblViewHolidayList.dataSource = self
        self.tblViewHolidayList.register(UINib(nibName:"HolidaylistHeaderReusableviewTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HolidaylistHeaderReusableviewTableViewCell")
        self.tblViewHolidayList.register(UINib(nibName:"HolidayListTableViewCell", bundle:nil), forCellReuseIdentifier: "HolidayListTableViewCell")
        self .callForHolidayListData()
        // Do any additional setup after loading the view.
    }
    
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
        cell.lblHolidayName.text = self.arrHolidayList[indexPath.row]["sis_name"] as? String
        cell.lblHolidayDate.text = self.arrHolidayList[indexPath.row]["new_startdate"] as? String
        cell.lblHolidayDay.text = self.arrHolidayList[indexPath.row]["new_dayname"] as? String
        cell.selectionStyle = .none
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        //destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
        let selectedLogin=UserDefaults.standard.string(forKey: "selectedLogin")
        if (selectedLogin == "student"){
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
            sideMenuController()?.setContentViewController(destViewController)
            
        }
        else if(selectedLogin == "E"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        else if(selectedLogin == "parent"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
    func callForHolidayListData(){
        self .showLoader()
        DispatchQueue.global().async {
            
            let stringHolidayDataCall = "http://43.224.136.81:5015/SIS_Student/Holidays"
            print (stringHolidayDataCall)
            let encodedString = stringHolidayDataCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedString!)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    self .hideLoader()
                    let swiftyJsonVar = JSON(responseData.result.value!)
                  //  self.arrHolidayList = swiftyJsonVar["value"]
                    print(swiftyJsonVar ["value"])
                    self.arrHolidayList = swiftyJsonVar ["value"].arrayObject as! [[String : Any]]
                    print(self.arrHolidayList [0])
                    DispatchQueue.main.async{
                        //put your code here
                        
                        self.tblViewHolidayList.reloadData()
                    }
                    
                    
                }else{
                     self .hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    func showLoader(){
        
        // https://www.cocoacontrols.com/controls/alloadingview
        
        ALLoadingView.manager.resetToDefaults()
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.animationDuration = 1.0
        ALLoadingView.manager.itemSpacing = 30.0
        ALLoadingView.manager.messageText = "Loading...."
        ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
        
    }
    func hideLoader(){
        
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        ALLoadingView.manager.resetToDefaults()
        
    }
    
}
