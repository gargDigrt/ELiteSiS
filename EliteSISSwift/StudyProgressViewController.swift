//
//  StudyProgressViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 26/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown
import SwiftyJSON

class StudyProgressViewController: UIViewController{
    
    //IBOutlet----
    @IBOutlet weak var subjectsTableView: UITableView!
    @IBOutlet weak var lblSelectedOption: UILabel!
    @IBOutlet weak var viewOptions: UIView!
    
    //Varibale---
    var pickerData: [String] = [String]()
    var subjectDataAry = [(String,String,String,String)]()
    var exam = ["Select exam"]
    var arrFA1 = [[String:String]]()
    var arrFA2 = [[String:String]]()
    var arrSA1 = [[String:String]]()
    var arrSA2 = [[String:String]]()
    var arrFinal = [[String:String]]()
    
    var arrValuesForTable = [[String:String]]()
    var dropDownClasses: DropDown!
    
    //MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
        
        getStudyProgress()
        configureTableView()
        self.configDropDown()
        
//        if UserDefaults.standard.string(forKey: "selectedLogin") == LoginUserType.TEACHER.rawValue{
//            pickerData = ["4th", "6th", "7th", "10th"]
//        }
//        else{
//            pickerData = ["FA1", "FA2", "SA1", "SA2", "Final"]
//        }

        self.onCategoryChange(withCategoryIndex: 0)
        self.lblSelectedOption.text = "Select exam"
    }
    
    //MARK:- Custom methods
    fileprivate func configureTableView() {
        subjectsTableView.register(UINib(nibName:"StudyProgressTableViewCell", bundle: nil), forCellReuseIdentifier: "StudyProgressTableViewCell")
        subjectsTableView.separatorStyle = .none
        subjectsTableView.delegate = self
        subjectsTableView.dataSource = self
    }
    
    func getStudyProgress() {
        let studentId = UserDefaults.standard.string(forKey: "sis_studentid")
        let sessionId = UserDefaults.standard.string(forKey: "_sis_currentclasssession_value")
        let sectionId = UserDefaults.standard.string(forKey: "_sis_section_value")
        
        ProgressLoader.shared.showLoader(withText: "")
        WebServices.shared.getPerformancelistFor(studentID: studentId!, sessionID: sessionId!, sectionID: sectionId!, completion: { (response, error) in
            
            if error == nil, let respondeDict = response {
                print(respondeDict)

                let marksID = respondeDict["value"][0]["sis_classsessionwisemarksid"].stringValue
                UserDefaults.standard.set(marksID, forKey: "sis_classsessionwisemarksid")

                // Set exam picker data
                let examName = respondeDict["value"][0]["examtype_x002e_sis_name"].stringValue
                self.pickerData.removeAll()
                self.pickerData.append(examName)
                self.configDropDown()
                //getStudyProgress
                WebServices.shared.getStudyProgress(marksID: marksID, completion: { (response, error) in
                    if error == nil, let respondeDict = response {
                        self.displayStudyProgress(withDict: respondeDict)
                    }else{
                        AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                        debugPrint(error?.localizedDescription ?? "Getting user study progress error")
                    }
                    ProgressLoader.shared.hideLoader()
                })
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user performance error")
            }
        })
    }
    
    func configDropDown(){
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        dropDownClasses.anchorView = viewOptions // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.pickerData
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblSelectedOption.text = self.pickerData[index]
            self.onCategoryChange(withCategoryIndex: index)
        }
    }
    
    func displayStudyProgress(withDict json:JSON) {
        let subjects = json["value"].arrayValue
        
        for item in subjects {
            let sub = (item["sis_name"].stringValue, item["sis_obtainedmarks"].stringValue, item["sis_totalmarks"].stringValue, item["new_performance"].stringValue)
            subjectDataAry.append(sub)
        }
        
    }
    
    func onStudentCategoryInfoClick(){
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else{
            dropDownClasses.hide()
        }
    }
    
    func onCategoryChange(withCategoryIndex row: Int){
        if row % 2 == 0 {
            arrValuesForTable = arrFA2
        } else {
            arrValuesForTable = arrFA1
        }
        
        subjectsTableView.reloadData()
    }

    func getAngle(value: Double, outOf: Double) -> Double {
        return 360 * (value / outOf)
    }
    
    // MARK: - Button actions
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        self.onStudentCategoryInfoClick()
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
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
}

//MARK:- UITableView Delegate & Datasource

extension StudyProgressViewController:  UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectDataAry.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudyProgressTableViewCell") as! StudyProgressTableViewCell
        cell.lblSubject.text = subjectDataAry[indexPath.row].0
//        cell.lblSubject.text = arrValuesForTable[indexPath.row]["sub"]
        cell.lblPercentage.text =  "\(subjectDataAry[indexPath.row].3)%"
//        cell.lblPercentage.text = "\(String(describing: arrValuesForTable[indexPath.row]["per"]!))%"
        
        let obtainMarks = Double(subjectDataAry[indexPath.row].1)
        let totalMarks = Double(subjectDataAry[indexPath.row].2)
        let newAngleValue = getAngle(value: obtainMarks!, outOf: totalMarks!)
        cell.circularProgress.animate(toAngle: newAngleValue, duration: 1.0, completion: nil)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ChapterStatusViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }

}
