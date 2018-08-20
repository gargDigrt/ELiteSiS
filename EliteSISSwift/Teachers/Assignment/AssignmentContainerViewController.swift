//
//  AssignmentContainerViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 05/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import CarbonKit

class AssignmentContainerViewController: UIViewController {
    @IBOutlet weak var viewContainer: UIView!
    var carbonTabSwipeNavigation: CarbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var items = NSArray()
    weak var assignmentVC: TeacherAssignmentViewController!
    var classType: String = ""
    @IBOutlet weak var btnAddAssignment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.btnAddAssignment.layer.cornerRadius = 25.0
        self.btnAddAssignment.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initView()
    }
    
    func initView(){
        self.setupSwipeNavigation()
    }
    
    /**
     *  This function setup the Swipe Navigation Bar
     *  @return void
     */
    
    func setupSwipeNavigation() ->Void
    {
        
        items = ["ALL", "DUE", "SUBMITTED"]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items as [AnyObject], delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: viewContainer)
        self.style()
    }
    
    
    /**
     *  This function setup the Swipe Navigation Design styles
     *  @return void
     */
    
    func style() {
        
        let width = (UIScreen.main.bounds.width-32)/3//self.viewContainer.bounds.width/3.35
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl!.setWidth(width, forSegmentAt: 2)

        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.setIndicatorColor(UIColor.orange)
        carbonTabSwipeNavigation.view.backgroundColor = UIColor.clear
        
        carbonTabSwipeNavigation.carbonTabSwipeScrollView.backgroundColor = UIColor(red: 73/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1.0)
        
        carbonTabSwipeNavigation.setNormalColor(UIColor.black.withAlphaComponent(0.8))
        carbonTabSwipeNavigation.setSelectedColor(UIColor.white, font: UIFont.boldSystemFont(ofSize: 14))
        carbonTabSwipeNavigation.setTabBarHeight(60)
        carbonTabSwipeNavigation.setTabExtraWidth(0)
        
    }

    @IBAction func btnBackClick(_ sender: Any) {
      //  self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func btnToggleMenuClick(_ sender: Any) {
       toggleSideMenuView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddAssignmentClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAssignmentViewController") as! AddAssignmentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension AssignmentContainerViewController: CarbonTabSwipeNavigationDelegate{
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch Int(index) {
        case TEACHER_ASSIGNMENT_TYPE.ALL.hashValue:
            let assignmentVC = self.storyboard?.instantiateViewController(withIdentifier: "TeacherAssignmentViewController") as! TeacherAssignmentViewController
            assignmentVC.classType = self.classType
            assignmentVC.assignmentType = .ALL
            return assignmentVC
        case TEACHER_ASSIGNMENT_TYPE.DUE.hashValue:
            let assignmentVC = self.storyboard?.instantiateViewController(withIdentifier: "TeacherAssignmentViewController") as! TeacherAssignmentViewController
            assignmentVC.classType = self.classType
            assignmentVC.assignmentType = .DUE
            return assignmentVC
        case TEACHER_ASSIGNMENT_TYPE.SUBMITTED.hashValue:
            let assignmentVC = self.storyboard?.instantiateViewController(withIdentifier: "TeacherAssignmentViewController") as! TeacherAssignmentViewController
            assignmentVC.classType = self.classType
            assignmentVC.assignmentType = .SUBMITTED
            return assignmentVC
        default:
            return UIViewController()
        }
    }
}

