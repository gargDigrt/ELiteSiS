//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ALLoadingView


class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var arrMenuValues = [String]()
    var arrMenuImages = [String]()
    var selectedLogin = UserDefaults.standard.string(forKey: "selectedLogin")
    let regid = UserDefaults.standard.string(forKey: "_sis_registration_value")!
    
    var arrUserProfile = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        if (!(arrUserProfile.count > 0)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.callForUserProfileData()
                        }
    }
}
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        if (!(arrUserProfile.count > 0)) {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.callForUserProfileData()
//            }
//        }
//
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
      if (selectedLogin == "S") {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuStudentInfoHeaderView") as! MenuStudentInfoHeaderView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
        }
      else if (selectedLogin == "E") {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuTeacherInfoHeaderView") as! MenuTeacherInfoHeaderView
    // let FacultyName = UserDefaults.standard.string(forKey: "FacultyName")!
        viewHeader.lblName.text = UserDefaults.standard.string(forKey: "FacultyName")!
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        /*
        print(self.arrUserProfile)
      //  viewHeader.lblName.text = self.arrUserProfile ["ApplicantFullName"]!
        let strClassName = self.arrUserProfile["className"]!
        let strSection = self.arrUserProfile["Section"]!
 
        viewHeader.lblMotherClass.text = " Mother teacher of - " + strClassName + " (" + strSection + ")"
        
        let decodedData = NSData(base64Encoded: self.arrUserProfile["Entityimage"]!, options: NSData.Base64DecodingOptions(rawValue: 0) )
 
        let decodedimage = UIImage(data: decodedData! as Data)
 
        viewHeader.imgView.image = decodedimage
        viewHeader.imgView.layer.cornerRadius = viewHeader.imgView.frame.size.width/2
        viewHeader.imgView.clipsToBounds = true
      //   */
        return viewHeader
      }
      else{
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuParentInfoHeaderView") as! MenuParentInfoHeaderView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (selectedLogin == "G"){
            return 70
        }
        else{
            return 100
        }
    }
    
   
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return arrMenuValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.textColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)///44 154 243blue
            let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
            
        }
        
//        let theImageView = UIImageView(image: UIImage(named:"progress.png")!.withRenderingMode(.alwaysTemplate))
//        theImageView.tintColor = UIColor.blue
//
        cell?.imageView?.image = UIImage(named:(arrMenuImages[indexPath.row]))!.withRenderingMode(.alwaysTemplate)
        //UIImage(named: arrMenuImages[indexPath.row])
        cell?.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        cell!.textLabel?.text = arrMenuValues[indexPath.row]//"ViewController #\(indexPath.row+1)"
        
        return cell!
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeadingTableViewCell") as! MenuHeadingTableViewCell
//            return cell
//        default:
//            var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
//
//            if (cell == nil) {
//                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
//                cell!.backgroundColor = UIColor.clear
//                cell!.textLabel?.textColor = UIColor.darkGray
//                let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
//                selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
//                cell!.selectedBackgroundView = selectedBackgroundView
//            }
//
//            cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
//
//            return cell!
//        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem) {
            //return
        }
        
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        if (selectedLogin == "S"){
            if (indexPath.row == 15) {
                hideSideMenuView()
                let alert = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: { action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }else{
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        switch (indexPath.row) {
            
        case 0:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "PinboardViewController")
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ParentChatViewController")
            break
            
        case 3:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "NotificationViewController")
            break
        case 4:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "timetableview")
            break
            
        case 5:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "AssignmentViewController")
            break
        case 6:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "performancescoreview")
            break
            
        case 7:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudyProgressViewController")
            break
        case 8:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teachersviewcontroller")
            break
            
        case 9:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "attendanceview")
            break
        case 10:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "EventGalleryListViewController")
            break
            
        case 11:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HealthReportViewController")
            break
        case 12:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HolidayListViewController")
            break
            
        case 13:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudentProfileViewController")
            break
            
        case 14:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
            break
        case 15:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
            break
            
        default:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController4")
            break
        }
        
        sideMenuController()?.setContentViewController(destViewController)
        }
        }
       else if (selectedLogin == "E"){
            if (indexPath.row == 15) {
                hideSideMenuView()
                let alert = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: { action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }else{
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            var destViewController : UIViewController
            
            switch (indexPath.row) {
                
            case 0:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
                break
            case 1:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherDailySchedule")
                break
            case 2:
               destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudentAttendanceViewController")
                break
                
            case 3:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "PinboardViewController")
                break
            case 4:
                    destViewController = self.getStudentProfileListingWithAction(actionType: .DISCUSSION)
                break
                
            case 5:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "AssignmentContainerViewController")
                break
                
            case 6:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudyProgressViewController")
                break
                
            case 7:
                destViewController = self.getStudentProfileListingWithAction(actionType: .DASHBOARD)
                break
            case 8:
                destViewController = self.getStudentProfileListingWithAction(actionType: .PROFILE)
                break
           case 9:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "FeeDefaulterViewController")
                break
            case 10:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "EventGalleryListViewController")
                break
                
            case 11:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HolidayListViewController")
                break
            case 12:
                destViewController =  mainStoryboard.instantiateViewController(withIdentifier: "teacherprofileviewcontroller")
                break
            case 13:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
                break
            case 14:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ComplaintsListViewController")
                break
                
            case 15:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
                break
                
            default:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
                break
            }
            
            sideMenuController()?.setContentViewController(destViewController)
        }
        }
        if (selectedLogin == "G"){
            if (indexPath.row == 8) {
                hideSideMenuView()
                let alert = UIAlertController(title: "Logout", message: "Do you really want to logout?", preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: { action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }else{
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
            var destViewController : UIViewController
            
            switch (indexPath.row) {
                
            case 0:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentdashboard")
                break
            case 1:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "PinboardViewController")
                break
            case 2:
               destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ParentChatViewController")
                break
            case 3:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "EventGalleryListViewController")
                break
            case 4:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HolidayListViewController")
                break
           case 5:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentprofileviewcontroller")
                break
            case 6:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
                break
            case 7:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ParentComplaintDetailViewController")
                break
            case 8:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "loginviewcontroller")
                break
            default:
                destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController4")
                break
            }
            
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        }
    }
    
    func getStudentProfileListingWithAction(actionType: StudentProfileActionType)->StudentProfileListingViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentProfileListingViewController") as! StudentProfileListingViewController
        vc.screenActionType = actionType
        return vc
    }
    
    func callForUserProfileData()  {
       self .showLoader()
        DispatchQueue.global().async {
            print(self.regid)
            
            let stringLoginCall = "http://43.224.136.81:5015/SIS/GetProfiledetails/" + self.regid
            print (stringLoginCall)
            let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedString!)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    self .hideLoader()
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    // let loginDataMain = swiftyJsonVar.dictionaryObject! as! [String: String]
                    
                   /*
                    self.arrUserProfile = swiftyJsonVar.dictionaryObject! as! [String: String]
                    print (self.arrUserProfile )
                    print ( self.arrUserProfile ["ApplicantFullName"]!)
                    */
                    if (self.selectedLogin == "S"){
                        // for Student Login  menu
                        self.arrMenuValues = ["Dashboard", "Pinboard", "Discussion", "Notification", "Time Table", "Assignment", "Performance/Score", "Study Progress", "Teachers", "Attendance", "Event/Gallery", "Health Report", "Holiday List", "My Profile", "Change Password", "Logout"]
                        
                        self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "notification.png", "calendar.png", "assignment.png", "performance.png", "progress.png", "teacher.png", "attendance.png", "event.png", "health.png", "holiday.png", "s_profile.png", "key.png", "logout.png"]
                    }
                        
                    else if(self.selectedLogin == "E"){
                        // for Teacher Login
                        self.arrMenuValues = ["Dashboard", "Daily Schedule", "Attendance", "Pinboard", "Discussion", "Assignment",  "Study Progress", "Student Dashboard", "Student Information","Fee Defaulter", "Event/Gallery", "Holiday List", "My Profile", "Change Password","Complaints", "Logout"]
                        
                        self.arrMenuImages = ["dashboard.png", "calendar.png", "attendance.png", "pinboard.png", "discussion.png", "assignment.png", "progress.png", "s_dashboard.png", "s_info.png", "fee.png", "event.png", "holiday.png",  "profile.png", "key.png","compliance.png", "logout.png"]
                    }
                        
                    else if(self.selectedLogin == "G"){
                        // for Teacher Login
                        self.arrMenuValues = ["Dashboard", "Pinboard", "Discussion", "Event/ Gallery", "Holiday List", "My Profile",  "Change Password", "Complaints","Logout"]
                        
                        self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "event.png", "holiday.png", "profile.png", "key.png", "compliance.png", "logout.png"]
                    }
                    
                    // Customize apperance of table view
                    //        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
                    self.tableView = UITableView.init(frame: .zero, style: .grouped)
                    self.tableView.separatorStyle = .none
                    self.tableView.backgroundColor = UIColor.clear
                    self.tableView.scrollsToTop = false
                    self.tableView.bounces = false
                    // Preserve selection between presentations
                    self.clearsSelectionOnViewWillAppear = false
                    
                    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
                    //self.tableView.estimatedSectionHeaderHeight = 100
                    
                    self.tableView.selectRow(at: IndexPath(row: self.selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
                    self.tableView.register(UINib(nibName:"MenuHeadingTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuHeadingTableViewCell")
                    self.tableView.register(UINib(nibName:"MenuStudentInfoHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MenuStudentInfoHeaderView")
                    self.tableView.register(UINib(nibName:"MenuTeacherInfoHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MenuTeacherInfoHeaderView")
                    self.tableView.register(UINib(nibName:"MenuParentInfoHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "MenuParentInfoHeaderView")
                    
                    
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
//                    self.tableView .reloadData()
                    self.tableView.frame.origin.y = self.tableView.frame.origin.y - 35
                    
                }else{
                    self .hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    func showLoader(){
        
        // https://www.cocoacontrols.com/controls/alloadingview
        ALLoadingView.manager.resetToDefaults()
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.animationDuration = 1.0
        ALLoadingView.manager.itemSpacing = 30.0
        ALLoadingView.manager.messageText = "Fetching data......."
        ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
        
    }
    func hideLoader(){
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        
    }
    
}
