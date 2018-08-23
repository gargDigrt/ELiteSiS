//
//  TeacherDashboardViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 30/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TeacherDashboardViewController: UIViewController {
    @IBOutlet weak var lblTodaySchedule: UILabel!
    @IBOutlet weak var collectionViewClass: UICollectionView!
    @IBOutlet weak var tblViewAssignments: UITableView!
    
    var arrDailySchedule = [AnyObject]()
    var arrTeacherDashboard = [Dictionary<String, Any>]()
     var strFacultyId = ""
    var strFacultyName = ""
    var dataSourceAssignment = AssignmentViewDataModel().getDummyData()
    var dataSourceClassInfo = ClassViewDataModel.getDummyData()
    let regid = UserDefaults.standard.string(forKey: "_sis_registration_value")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        // Do any additional setup after loading the view.
        
        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.callforGetFaculty()
            }
        
        
        //Configure Table View
        self.configTableView()
        
        //Configure Collection View
        self.configCollectionView()
        
        //Set Date
        self.setTodaysScheduleLabel()
        
        self.getTeacherDashboard()
    }
    
    func getTeacherDashboard(){

        DispatchQueue.global().async {
            
            let stringLoginCall = "http://43.224.136.81:5015/SIS/GetFacultydashboard/" + self.regid
            let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    self.arrTeacherDashboard = responseData.result.value as! [Dictionary<String, Any>]
                    print(self.arrTeacherDashboard)
                    self.tblViewAssignments.reloadData()
                }else{
                     ProgressLoader.shared.hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTodaysScheduleLabel(){
        self.lblTodaySchedule.text = "Today's Schedule \(Date.getCurrentDateWithFormat())"
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
    
    @IBAction func btnStudentAttendanceClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentAttendanceViewController") as! StudentAttendanceViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPinboardClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PinboardViewController") as! PinboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnStudentProfileClick(_ sender: Any) {
        self.showStudentProfileListingWithAction(actionType: .PROFILE)
    }
    
    @IBAction func btnDiscussionClick(_ sender: Any) {
        self.showStudentProfileListingWithAction(actionType: .DISCUSSION)
    }
    
    func showStudentProfileListingWithAction(actionType: StudentProfileActionType){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentProfileListingViewController") as! StudentProfileListingViewController
        vc.screenActionType = actionType
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - Table View Setup
extension TeacherDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func configTableView() {
        self.tblViewAssignments.delegate = self
        self.tblViewAssignments.dataSource = self
        self.tblViewAssignments.separatorStyle = .none
        
        self.tblViewAssignments.register(UINib(nibName: "TeacherAssignmentTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TeacherAssignmentTableViewCell")
        
        self.tblViewAssignments.reloadData()
    }
    
    //MARK: Table view delegate and datasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTeacherDashboard.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherAssignmentTableViewCell") as! TeacherAssignmentTableViewCell
        cell.config(data: arrTeacherDashboard[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "segueAssignment", sender: nil)
        
        let vcAssignment = self.storyboard?.instantiateViewController(withIdentifier: "AssignmentContainerViewController") as! AssignmentContainerViewController
        vcAssignment.classType = self.dataSourceAssignment[indexPath.row].className
        self.navigationController?.pushViewController(vcAssignment, animated: true)
    }
}


// MARK: - Collection View Setup
extension TeacherDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func configCollectionView(){
        self.collectionViewClass.delegate = self
        self.collectionViewClass.dataSource = self
        
        self.collectionViewClass.register(UINib(nibName: "ClassInfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ClassInfoCollectionViewCell")
        self.collectionViewClass.reloadData()
    }
    
    //MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(arrDailySchedule)
        return arrDailySchedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0 - 10.0
        let yourHeight = collectionView.bounds.height/2.0 - 5.0
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassInfoCollectionViewCell", for: indexPath) as! ClassInfoCollectionViewCell
       
        
        if let dic = arrDailySchedule[indexPath.row] as? [String : AnyObject]
        {
            if let strSection = dic["Section"] as? String
            {
                cell.lblClassNumber.text = strSection
            }
            if (dic["start_time"] as? String) != nil
           {
            let strClassTimeStartAndEnd = NSString (string: "\(arrDailySchedule[indexPath.row]["start_time"] as AnyObject) - \(arrDailySchedule[indexPath.row]["end_time"] as AnyObject)") as String
            
            cell.lblClassTiming.text = strClassTimeStartAndEnd
            }
            if let strSubject = dic["subject"] as? String
            {
                cell.lblSubject.text  = strSubject
            }
            if let strChapter = dic["chapter"] as? String
            {
                cell.lblChapter.text = strChapter
            }
            if let strClassName = dic["className"] as? String
            {
                cell.lblClassName.text = strClassName
            }
        }
        
       // cell.config(data: dataSourceClassInfo[indexPath.row])
        return cell
    }
    
    func callForDashboardData(){
        
        DispatchQueue.global().async {
         //   http://43.224.136.81:5015/SIS/DailySchedule/316d7818-ae8b-e711-814a-c4346bdd31a1/MBLE_APP_00001
            let stringLoginCall = "http://43.224.136.81:5015/SIS/DailySchedule/" + self.strFacultyId + "/MBLE_APP_00001"
            print (stringLoginCall)
            let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedString!)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    ProgressLoader.shared.hideLoader()
                     let swiftyJsonVar = JSON(responseData.result.value!)
                    self.arrDailySchedule = JSON(responseData.result.value!).arrayObject! as [AnyObject]
                    print(self.arrDailySchedule)
                    print(swiftyJsonVar)
                 self.collectionViewClass.reloadData()
                } else {
                     ProgressLoader.shared.hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func callforGetFaculty(){
       
       // self .showLoader()
        DispatchQueue.global().async {
            
            let stringLoginCall = "http://43.224.136.81:5015/SIS/GetFacultyFromRegistrationID/" + self.regid  + "/MBLE_APP_00001"
            print (stringLoginCall)
            let encodedString = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedString!)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                   ProgressLoader.shared.hideLoader()
                    let swiftyJsonVar = JSON(responseData.result.value!)
                   print(swiftyJsonVar)
                    self.strFacultyName = swiftyJsonVar ["FacultyName"].stringValue
                    self.strFacultyId = swiftyJsonVar ["FacultyID"].stringValue
                    UserDefaults.standard.set(self.strFacultyName, forKey: "FacultyName")

                    
                    self .callForDashboardData()
                }else{
                    ProgressLoader.shared.hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
    }
}

