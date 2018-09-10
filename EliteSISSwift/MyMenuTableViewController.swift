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


class MyMenuTableViewController: UITableViewController {
    
    //VAriables
    var selectedMenuItem : Int = 0
    var arrMenuValues = [String]()
    var sideMenuItems = [String]()
    var arrMenuImages = [String]()
    var selectedLogin = UserDefaults.standard.string(forKey: "selectedLogin")
    var arrUserProfile = [String:String]()
    var classNameValue:String = ""
    
    // MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        if (!(arrUserProfile.count > 0)) {
            //            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //                            self.callForUserProfileData()
            self.getMenuListItems()
            //            }
        }
    }
    
    func getStudentProfileListingWithAction(actionType: StudentProfileActionType)->StudentProfileListingViewController{
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StudentProfileListingViewController") as! StudentProfileListingViewController
        vc.screenActionType = actionType
        return vc
    }
    
    func getUserProfileData()  {
        
        guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else {
            return
        }
        
        // Getting USer profile
        WebServices.shared.getProfile(forRegistrationID: regID, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                
                //  UserDefaults.standard.setValue(responseDict, forKey: "DictValue")
                
                
                let className1 = responseDict["value"][0]["sis_currentclasssession"]["sis_name"].stringValue
                let fullNameArr = className1.split(separator: " ")
                self.classNameValue = "\(fullNameArr[1])(\(responseDict["value"][0]["sis_section"]["sis_name"]))"
                 UserDefaults.standard.set(className1, forKey: "_sis_class_value")
                
                let classSession = responseDict["value"][0]["_sis_currentclasssession_value"].stringValue
                UserDefaults.standard.set(classSession, forKey: "_sis_currentclasssession_value")
                
                let studentID = responseDict["value"][0]["sis_studentid"].stringValue
                UserDefaults.standard.set(studentID, forKey: "sis_studentid")
                
                if let imgString = responseDict["value"][0]["entityimage"].string {
                    let studentImage = UIImage.decodeBase64(toImage: imgString)
                    let imgData = UIImagePNGRepresentation(studentImage)
                    UserDefaults.standard.set(imgData, forKey: "studentImage")
                }
                
                let parentsName = responseDict["value"][0]["sis_fathername"].stringValue
                UserDefaults.standard.set(parentsName, forKey: "sis_fathername")
                
                let motherName = responseDict["value"][0]["sis_mothername"].stringValue
                UserDefaults.standard.set(motherName, forKey: "sis_mothername")
                
                let sectionID = responseDict["value"][0]["_sis_section_value"].stringValue
                UserDefaults.standard.set(sectionID, forKey: "_sis_section_value")
                
                let contactID = responseDict["value"][0]["_sis_studentname_value"].stringValue
                UserDefaults.standard.set(contactID, forKey: "_sis_studentname_value")
                
                let GenderId = responseDict["value"][0]["sis_gender"].stringValue
                UserDefaults.standard.set(GenderId, forKey: "sis_gender")
                
                let categoryID = responseDict["value"][0]["sis_category"].stringValue
                UserDefaults.standard.set(categoryID, forKey: "sis_category")
                
                let DOB = responseDict["value"][0]["sis_dateofbirth"].stringValue
                UserDefaults.standard.set(DOB, forKey: "sis_dateofbirth")
                
                let ContactNo = responseDict["value"][0]["sis_primarymobilenumber"].stringValue
                UserDefaults.standard.set(ContactNo, forKey: "sis_primarymobilenumber")
                
                let emailId = responseDict["value"][0]["emailaddress"].stringValue
                UserDefaults.standard.set(emailId, forKey: "emailaddress")
                
                let admissionDate = responseDict["value"][0]["sis_dateofadmission"].stringValue
                UserDefaults.standard.set(admissionDate, forKey: "sis_dateofadmission")
                
                let RegistrationNo = responseDict["value"][0]["sis_registration"]["sis_name"].stringValue
                UserDefaults.standard.set(RegistrationNo, forKey: "sis_registration")
                self.setupDisplay()
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    func setupDisplay() {
        
        if (self.selectedLogin == "S") {
            self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "notification.png", "calendar.png", "assignment.png", "performance.png", "teacher.png", "attendance.png", "event.png", "health.png", "holiday.png", "profile.png", "key.png", "logout.png"]
        }
        
        
        //        else if(self.selectedLogin == "E"){
        //            // for Teacher Login
        //            self.arrMenuValues = ["Dashboard", "Daily Schedule", "Attendance", "Pinboard", "Discussion", "Assignment",  "Study Progress", "Student Dashboard", "Student Information","Fee Defaulter", "Event/Gallery", "Holiday List", "My Profile", "Change Password","Complaints", "Logout"]
        //
        //            self.arrMenuImages = ["dashboard.png", "calendar.png", "attendance.png", "pinboard.png", "discussion.png", "assignment.png", "progress.png", "s_dashboard.png", "s_info.png", "fee.png", "event.png", "holiday.png",  "profile.png", "key.png","compliance.png", "logout.png"]
        //        }
        //
        //        else if(self.selectedLogin == "G"){
        //            // for Teacher Login
        //            self.arrMenuValues = ["Dashboard", "Pinboard", "Discussion", "Event/ Gallery", "Holiday List", "My Profile",  "Change Password", "Complaints","Logout"]
        //
        //            self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "event.png", "holiday.png", "profile.png", "key.png", "compliance.png", "logout.png"]
        //        }
        
        self.tableView = UITableView.init(frame: .zero, style: .grouped)
        let statusBarHeight = UIApplication.shared.keyWindow!.safeAreaInsets.top
        self.tableView.frame.origin = CGPoint(x: 0, y: statusBarHeight)
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
        self.tableView.reloadData()
        self.tableView.frame.origin.y = self.tableView.frame.origin.y - 35
        
        //        if let userProfileCell = self.tableView.headerView(forSection: 0) as? MenuStudentInfoHeaderView {
        //            let studentID = dict["value"][0]["sis_studentid"].stringValue
        //            userProfileCell.lblId.text = studentID
        //            let parentsName = dict["value"][0]["sis_fathername"].stringValue
        //            userProfileCell.lblParentName.text = parentsName
        //        }
        
    }
    
    func getMenuListItems() {
        
        guard let roleCode = UserDefaults.standard.string(forKey: "new_rolecode") else { return }
        
        WebServices.shared.menuListItem(role: roleCode, completion: {(response,error) in
            if error == nil, let responceDict = response {
                
                let schoolID = responceDict["Name"].stringValue
                UserDefaults.standard.set(schoolID, forKey: "Name")
                
                
                self.sideMenuItems.append("Dashboard")
                
                if (responceDict["PinBoard"] == true){
                    self.sideMenuItems.append("Pinboard")
                }
                
                if (responceDict["Discussion"] == true){
                    self.sideMenuItems.append("Discussion")
                }
                
                if (responceDict["Notification"] == true){
                    self.sideMenuItems.append("Notification")
                }
                
                if (responceDict["TimeTable"] == true){
                    self.sideMenuItems.append("Time Table")
                }
                
                if (responceDict["Assignment"] == true){
                    self.sideMenuItems.append("Assignment")
                }
                
                if (responceDict["PerformanceScore"] == true){
                    self.sideMenuItems.append("Performance / Score")
                }
                // need to check it
                if (responceDict["StudyProgress"] == true){
                    self.sideMenuItems.append("Study Progress")
                }
                //
                if (responceDict["Teachers"] == true){
                    self.sideMenuItems.append("Teachers")
                }
                
                if (responceDict["Attendance"] == true){
                    self.sideMenuItems.append("Attendance")
                }
                
                if (responceDict["EventGallery"] == true){
                    self.sideMenuItems.append("Event / Gallery")
                }
                
                if (responceDict["HealthReport"] == true){
                    self.sideMenuItems.append("Health Report")
                }
                
                if (responceDict["HolidayList"] == true){
                    self.sideMenuItems.append("Holiday List")
                }
                
                if (responceDict["MyProfile"] == true){
                    self.sideMenuItems.append("My Profile")
                }
                
                self.sideMenuItems.append("Change Password")
                self.sideMenuItems.append("Logout")
                
                print(self.sideMenuItems)
                self.getUserProfileData()
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error Occured!", message: "Please try after some time")
            }
        })
    }
}
// MARK: - UITableview Datasourfce and delegates

extension MyMenuTableViewController {
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (selectedLogin == "S") {
            let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MenuStudentInfoHeaderView") as! MenuStudentInfoHeaderView
            viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
            
            viewHeader.lblClass.text = "Class: " + self.classNameValue
            
            if let userID = UserDefaults.standard.string(forKey: "sis_user_id") {
                viewHeader.lblId.text = "ID: " + userID
            }
            if let imageData = UserDefaults.standard.data(forKey: "studentImage"){
                viewHeader.imgViewStudent.image = UIImage(data: imageData)
            }
            if let fatherName = UserDefaults.standard.string(forKey: "sis_fathername") {
                viewHeader.lblParentName.text = "Parent Name: Mr. " + fatherName
            }
            if let sisName = UserDefaults.standard.string(forKey: "sis_name") {
                viewHeader.lblStudentName.text = "Student Name: " + sisName
            }
            
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return sideMenuItems.count
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
        cell!.textLabel?.text = sideMenuItems[indexPath.row]//"ViewController #\(indexPath.row+1)"
        
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
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
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
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teachersviewcontroller")
                    break
                    
                case 8:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "attendanceview")
                    break
                case 9:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "EventGalleryListViewController")
                    break
                    
                case 10:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HealthReportViewController")
                    break
                case 11:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HolidayListViewController")
                    break
                    
                case 12:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudentProfileViewController")
                    break
                    
                case 13:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
                    break
                case 14:
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
    
}

