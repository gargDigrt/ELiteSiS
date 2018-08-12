//
//  StudentProfileListingViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 07/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown

enum StudentProfileActionType {
    case PROFILE
    case DISCUSSION
    case DASHBOARD
}

class StudentProfileListingViewController: UIViewController {
    
    var dataSourceClassses = ["4th", "5th", "6th", "7th"]
    var dataSourceStudentAttendance = StudentAttendanceViewModel().getDummyData()
    var dropDownStudents: DropDown!
    @IBOutlet weak var viewClassSelection: UIView!
    @IBOutlet weak var lblSelectedClass: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedClass = "4th"
    var screenActionType: StudentProfileActionType = StudentProfileActionType.PROFILE

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configDropDown()
        self.configCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configDropDown(){
        dropDownStudents = DropDown()
        
        // The view to which the drop down will appear on
        dropDownStudents.anchorView = self.viewClassSelection // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownStudents.dataSource = self.dataSourceClassses
        
        dropDownStudents.selectionAction = { [unowned self] (index: Int, item: String) in
            self.showStudentsClass(classSelected: item)
        }
    }
    
    func showStudentsClass(classSelected: String){
        self.lblSelectedClass.text = classSelected
        self.selectedClass = classSelected
        self.collectionView.reloadData()
    }
    
    @IBAction func btnSelectClassClick(_ sender: Any) {
        if dropDownStudents.isHidden{
            dropDownStudents.show()
            hideSideMenuView()
        }
        else{
            dropDownStudents.hide()
        }
    }
    
    @IBAction func btnSideMenuClick(_ sender: Any) {
        self.toggleSideMenuView()
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
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
    
    func studentSelected(student: StudentAttendanceViewModel, row: Int){
        switch screenActionType{
            case .PROFILE:
                self.moveToStudentProfile(student: student)
            case .DISCUSSION:
                self.moveToDiscussion(student: student, row: row)
            case .DASHBOARD:
                self.moveToStudentDashboard(student: student)
        }
    }
    
    func moveToStudentProfile(student: StudentAttendanceViewModel){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StudentProfileViewController") as! StudentProfileViewController
        vc.studentDetail = student
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToDiscussion(student: StudentAttendanceViewModel, row: Int){
        //Show Selection Screen
        let alertController = UIAlertController(title: "", message: "Select", preferredStyle: .actionSheet)
        
        let actionStudent = UIAlertAction(title: student.name, style: .default) { (action) in
            self.moveToChatScreenWithData(data: student, nameString: student.name)
        }
        
        let actionFather = UIAlertAction(title: "Father", style: .default) { (action) in
            self.moveToChatScreenWithData(data: student, nameString: "Father")
        }
        
        let actionMother = UIAlertAction(title: "Mother", style: .default) { (action) in
            self.moveToChatScreenWithData(data: student, nameString: "Mother")
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
       
        alertController.addAction(actionStudent)
        alertController.addAction(actionFather)
        alertController.addAction(actionMother)
        alertController.addAction(actionCancel)
        
        if let popoverPresentationController = alertController.popoverPresentationController{
            popoverPresentationController.sourceView = collectionView.cellForItem(at: IndexPath(row: row, section: 0))
            popoverPresentationController.sourceRect = (collectionView.cellForItem(at: IndexPath(row: row, section: 0))?.bounds)!
        }

        self.present(alertController, animated: true, completion: nil)
    }
    
    func moveToChatScreenWithData(data: StudentAttendanceViewModel, nameString:String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TeacherChatViewController") as! TeacherChatViewController
        vc.nameString = nameString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func moveToStudentDashboard(student: StudentAttendanceViewModel){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
        vc.studentName = student.name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Collection View Setup
extension StudentProfileListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func configCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "StudentCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "StudentCollectionViewCell")
        self.collectionView.reloadData()
    }
    
    //MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourceStudentAttendance[selectedClass]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: 110)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath) as! StudentCollectionViewCell
        cell.Config(data: self.dataSourceStudentAttendance[selectedClass]![indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedStudent = self.dataSourceStudentAttendance[selectedClass]![indexPath.row]
        self.studentSelected(student: selectedStudent, row: indexPath.row)
    }
}
