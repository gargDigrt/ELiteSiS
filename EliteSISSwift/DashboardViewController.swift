//
//  ViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny on 03.08.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, ENSideMenuDelegate {
    
    @IBOutlet weak var circularProgressView: KDCircularProgress!
    @IBOutlet weak var circularProgressViewSubject: KDCircularProgress!
    @IBOutlet weak var circularProgressViewDay: KDCircularProgress!
    @IBOutlet weak var circularProgressViewOverall:
    KDCircularProgress!
    
    @IBOutlet weak var viewAssignmentStatus: UIView!
    
    @IBOutlet weak var lblStudentName: UILabel!
    
    var studentName:String!
    
    @IBOutlet weak var viewAssignmentTap: UIView!
    @IBOutlet weak var viewStudyProgress: UIView!
    @IBOutlet weak var viewAttendance: UIView!
    @IBOutlet weak var viewPerformance: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    var currentCount = 0.0
    var currentCount1 = 0.0
    var currentCount2 = 0.0
    var currentCount3 = 0.0
    let maxCount = 100.0
    
    var allowBack = false
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        self.sideMenuController()?.sideMenu?.delegate = self
        self.navigationController?.navigationBar.isHidden = true;
        
        // for circular Progress
        currentCount += 80;
        let newAngleValue = newAngle()
        circularProgressView.animate(toAngle: newAngleValue, duration: 1.0, completion: nil)
        
        currentCount = 68;
        let newAngleProfressViewSubjectValue = newAngle()
        circularProgressViewSubject.animate(toAngle: newAngleProfressViewSubjectValue, duration: 1.0, completion: nil)
        
        currentCount = 45;
        let newAngleProgressViewDayValue = newAngle()
        circularProgressViewDay.animate(toAngle: newAngleProgressViewDayValue, duration: 1.0, completion: nil)
        
         currentCount = 75;
        let newAngleProgressViewOverallValue = newAngle()
        circularProgressViewOverall.animate(toAngle: newAngleProgressViewOverallValue, duration: 1.0, completion: nil)

        let tapGestureAssignmentStatus = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showAssignment))
        viewAssignmentTap.addGestureRecognizer(tapGestureAssignmentStatus)
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showStudyProgress))
        viewStudyProgress.addGestureRecognizer(tapGesture)
        
        let tapGestureAttendance = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showAttendace))
        viewAttendance.addGestureRecognizer(tapGestureAttendance)
        
        let tapgesturePerformance = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.showOveAllperformance))
        viewPerformance.addGestureRecognizer(tapgesturePerformance)
        
        if studentName != nil {
            lblStudentName.text = studentName
        }
        if allowBack {
            self.btnBack.isHidden = false
        }
        else {
            self.btnBack.isHidden = true
        }
    }
    
   
    
    func newAngle() -> Double {
        return 360 * (currentCount / maxCount)
    }
    
    @IBAction func showMenu(_ sender: Any) {
    toggleSideMenuView()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
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


