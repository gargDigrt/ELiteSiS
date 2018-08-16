//
//  StudentAttendanceViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 06/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import ALLoadingView
import SwiftyJSON

class StudentAttendanceViewController: UIViewController {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewClassSelection: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSelectedClass: UILabel!
    
    var arrClassName = [AnyObject]()

    var dropDownClasses: DropDown!
    var dataSourceClassses = [String]()
    var dataSourceStudentAttendance = StudentAttendanceViewModel().getDummyData()
    var selectedClass = "I(I-A)"
    var StrClassName = ""
    var StrSection = ""
    var StrSectionID = ""
    var regid = UserDefaults.standard.string(forKey: "_sis_registration_value")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.callForDropDownData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initView()
    }
    
    func initView(){
        self.lblDate.text = "Attendance " + Date.getCurrentDateWithFormat()
    }
    
    func configDropDown(){
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        dropDownClasses.anchorView = self.viewClassSelection // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.dataSourceClassses
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.showAttendanceForClass(classSelected: item)
        }
    }
    
    func showAttendanceForClass(classSelected: String){
        self.lblSelectedClass.text = classSelected
        self.selectedClass = classSelected
        self.tblView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
       // self.navigationController?.popViewController(animated: true)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
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
    
    @IBAction func btnSideMenuClick(_ sender: Any) {
        self.toggleSideMenuView()
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
       
    }
    
    @IBAction func selectClassTypeClick(_ sender: Any) {
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else{
            dropDownClasses.hide()
        }
    }
    
    
    //MARK: dropdown data list
func callForDropDownData() {
            DispatchQueue.global().async {
                    print(self.regid)
                    let stringLoginCall = "http://43.224.136.81:5015/SIS/getAttendenceClasses/" + self.regid  + "/MBLE_APP_00001"
                    print (stringLoginCall)
                    let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                    print(encodedString!)
                    Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                        if((responseData.result.value) != nil) {
                            self .hideLoader()
                            let swiftyJsonVar = JSON(responseData.result.value!)
                            self.arrClassName = JSON(responseData.result.value!).arrayObject! as [AnyObject]
            
                            print(swiftyJsonVar)
                            
                            for dic in self.arrClassName
                            {
                            
                                if let strClassName = dic["className"] as? String
                                {
                                    self.StrClassName = strClassName
                                }
                                if let strSection = dic["Section"] as? String {
                                   self.StrSection = strSection
                                }
                                
                                if let strSectionID = dic["Sectionid"] as? String {
                                    self.StrSectionID = strSectionID
                                    print(strSectionID)
                                }
                                
                                self.selectedClass = "\(dic["className"] as? String ?? "")(\(dic["Section"] as? String ?? ""))"
                                self.dataSourceClassses.append("\(self.StrClassName)(\(self.StrSection))")
                                print(self.dataSourceClassses[0])
                                
                                print(self.selectedClass)
                                self.configDropDown()
                               // self.configTableView()
                                self.callForStudentList()
                            }
                            
                        } else {
                            self .hideLoader()
                            let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
    }


//MARK: Student list class wise
func callForStudentList()  {
    DispatchQueue.global().async {
        // http://43.224.136.81:5015/SIS/getAttendenceClasses/1D739084-AB47-E811-8185-C4346BDD2141/MBLE_APP_00001
        let stringLoginCall = "http://43.224.136.81:5015/SIS/getAttendenceClasses/" + self.StrSectionID + "/MBLE_APP_00001"
        print (stringLoginCall)
        let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        print(encodedString!)
        Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                self .hideLoader()
                let swiftyJsonVar = JSON(responseData.result.value!)
                self.arrClassName = JSON(responseData.result.value!).arrayObject! as [AnyObject]
                
                print(swiftyJsonVar)
            } else {
                self .hideLoader()
                let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            }
}
    }
}

// MARK: - Table View Setup
extension StudentAttendanceViewController: UITableViewDelegate, UITableViewDataSource {
    func configTableView(){
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.separatorStyle = .none
        
        self.tblView.register(UINib(nibName: "StudentAttendanceTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "StudentAttendanceTableViewCell")
        self.tblView.register(UINib(nibName: "StudentAttendanceHeaderFooterView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "StudentAttendanceHeaderFooterView")
        
        self.tblView.reloadData()
    }
    
    //MARK: Table view delegate and datasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.dataSourceStudentAttendance[selectedClass]!.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StudentAttendanceHeaderFooterView") as! StudentAttendanceHeaderFooterView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentAttendanceTableViewCell") as! StudentAttendanceTableViewCell
        let cellDataSource = self.dataSourceStudentAttendance[selectedClass]![indexPath.row]
        cell.config(studentData: cellDataSource)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
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




