//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, ENSideMenuDelegate {
    
    //IBOutlets
    @IBOutlet weak var assignmentProgressView: KDCircularProgress!
    @IBOutlet weak var studyProgressView: KDCircularProgress!
    @IBOutlet weak var attendenceProgressView: KDCircularProgress!
    @IBOutlet weak var overallPerformanceProgressView:
    KDCircularProgress!
    
    @IBOutlet weak var dueAssignmentLabel: UILabel!
    @IBOutlet weak var allAssignmentLabel: UILabel!
    @IBOutlet weak var assignmentPercentLabel: UILabel!
    @IBOutlet weak var studyProgressPercentLabel: UILabel!
    @IBOutlet weak var subjectNumberLabel: UILabel!
    @IBOutlet weak var attendencePercentLabel: UILabel!
    @IBOutlet weak var totalDayLabel: UILabel!
    @IBOutlet weak var performancePercentLabel: UILabel!
    @IBOutlet weak var performanceNumberLabel: UILabel!
    
    @IBOutlet weak var viewAssignmentStatus: UIView!
    
    @IBOutlet weak var studentNameLabel: UILabel!
    
    @IBOutlet weak var viewAssignmentTap: UIView!
    @IBOutlet weak var viewStudyProgress: UIView!
    @IBOutlet weak var viewAttendance: UIView!
    @IBOutlet weak var viewPerformance: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    // Variables
    var studentName:String!
    var allowBack = false
    
    //MARK: - View's Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationController?.navigationBar.isHidden = true;
        
        getDasboardDetailsForUser()
        
        let tapGestureAssignmentStatus = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showAssignment))
        viewAssignmentTap.addGestureRecognizer(tapGestureAssignmentStatus)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showStudyProgress))
        viewStudyProgress.addGestureRecognizer(tapGesture)
        
        let tapGestureAttendance = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showAttendace))
        viewAttendance.addGestureRecognizer(tapGestureAttendance)
        
        let tapgesturePerformance = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showOveAllperformance))
        viewPerformance.addGestureRecognizer(tapgesturePerformance)
        
        if let sisName = UserDefaults.standard.value(forKey: "sis_name") as? String{
            studentNameLabel.text = sisName
        }
        
        if allowBack {
            self.btnBack.isHidden = false
        }
        else {
            self.btnBack.isHidden = true
        }
        
    }
    
    // MARK:- Custom methods
    
    private func setupProgressCircles(withData dict:[String: Any]) {
        // for circular Progress
        
        let totalAssignment = dict["new_totalassignments"] as! Int
        allAssignmentLabel.text = "\(totalAssignment)"
        
        let completAssignment = dict["new_completedassignments"] as! Int
        let dueAssignment = totalAssignment - completAssignment
        dueAssignmentLabel.text = "\(dueAssignment)"
        let completed = ((completAssignment * 100 ) / totalAssignment)
        assignmentPercentLabel.text = "\((completAssignment * 100 ) / totalAssignment)% COMPLETE"
        print(totalAssignment)
        print(dueAssignment)
        print(completed)
        let newAngleValue = getAngle(value: Double(completed), outOf:100)
        assignmentProgressView.animate(toAngle: newAngleValue, duration: 1.0, completion: nil)
        
        let totalSubject = dict["new_totalsubjects"] as! Int
        subjectNumberLabel.text = "\(totalSubject)"
        
        let studyProgress = dict["new_studyprogress"] as! Double
        studyProgressPercentLabel.text = "\(studyProgress)%"
        let newAngleProfressViewSubjectValue = getAngle(value: studyProgress, outOf: 100)
        studyProgressView.animate(toAngle: newAngleProfressViewSubjectValue, duration: 1.0, completion: nil)
        
        
        let presentDay = dict["new_presentdays"] as! Double
        let totalDay = dict["new_totalclasses"] as! Double
        let totalDays = dict["new_presentdays"] as! Int
        totalDayLabel.text = "\(totalDays)"
        let perCent = 100*presentDay/totalDay

        attendencePercentLabel.text = "\(String(format:"%.1f", perCent))%"
        let newAngleProgressViewDayValue = getAngle(value: perCent, outOf: 100)
        attendenceProgressView.animate(toAngle: newAngleProgressViewDayValue, duration: 1.0, completion: nil)
        
        let percentage = dict["new_percentage"] as! Double
        performancePercentLabel.text = "\(percentage)%"
        let newAngleProgressViewOverallValue = getAngle(value: 75, outOf: 100)
        overallPerformanceProgressView.animate(toAngle: newAngleProgressViewOverallValue, duration: 1.0, completion: nil)
        
        let overall = dict["new_obtainedmarks"] as! Int
        performanceNumberLabel.text = "\(overall)"
    }
    
    private func getDasboardDetailsForUser() {
        
        guard let classSession = UserDefaults.standard.string(forKey: "_sis_currentclasssession_value"),
            let studentID = UserDefaults.standard.string(forKey: "sis_studentid") else {
                
                if UserDefaults.standard.bool(forKey: "isFirstTime") {
                    self.getUserProfileData()
                    return
                }else{
                    AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                    return
                }
        }
        // getting dashboard details
        WebServices.shared.getDashboardDetailsFor(classSession: classSession, studentId: studentID, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                let dashboardDict = responseDict["value"][0].dictionaryObject
                self.setupProgressCircles(withData: dashboardDict!)
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting dashboard details error")
            }
            ProgressLoader.shared.hideLoader()
        })
        
    }
    
    func getUserProfileData()  {
        
        guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else {
            return
        }
        
        // Getting USer profile
        WebServices.shared.getProfile(forRegistrationID: regID, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                
                let classSession = responseDict["value"][0]["_sis_currentclasssession_value"].stringValue
                UserDefaults.standard.set(classSession, forKey: "_sis_currentclasssession_value")
                
                let studentID = responseDict["value"][0]["sis_studentid"].stringValue
                UserDefaults.standard.set(studentID, forKey: "sis_studentid")
                self.getDasboardDetailsForUser()
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    
    func getAngle(value: Double, outOf: Double) -> Double {
        return 360 * (value / outOf)
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
    //MARK:- selector methods
    
    @objc func showStudyProgress() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudyProgressViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @objc func showAttendace() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "attendanceview")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @objc func showOveAllperformance() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "performancescoreview")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @objc func showAssignment() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "AssignmentViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
        
    }
    
    //MARK: - Action methods
    
    @IBAction func showMenu(_ sender: Any) {
        toggleSideMenuView()
        
    }
    
    @IBAction func toggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    @IBAction func showTimetable(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "timetableview")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @IBAction func showHealthScreen(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "HealthReportViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @IBAction func showDiscussionScreen(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "ParentChatViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    
    @IBAction func showPinboardScreen(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "PinboardViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    @IBAction func btnBackClick(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}


