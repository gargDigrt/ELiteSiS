//
//  TeachersViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 16/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeachersViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, TeachersViewActionMethods {

    @IBOutlet weak var tblViewTeachers: UITableView!
    var faculties = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getFacultyListToDisplay()
        // Do any additional setup after loading the view.
        tblViewTeachers.separatorStyle = .none
        tblViewTeachers.register(UINib(nibName: "TeachersTableViewCell", bundle:nil), forCellReuseIdentifier: "TeachersTableViewCell")
        tblViewTeachers.register(UINib(nibName:"TeachersHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "TeachersHeaderView")
        
        tblViewTeachers.sectionHeaderHeight = 50
        tblViewTeachers.rowHeight = UITableViewAutomaticDimension
        tblViewTeachers.delegate = self
        tblViewTeachers.dataSource = self
        
    }
    
    
    func getFacultyListToDisplay() {
        
        guard let classSession = UserDefaults.standard.object(forKey: "_sis_currentclasssession_value") as? String else { return }
        WebServices.shared.getLessionPlansFor(classSession: classSession, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                self.faculties = responseDict["value"].arrayValue
                self.tblViewTeachers.reloadData()
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "fetching dashboard error")
                
            }
        })
    }
    
    func showTeachersProfile() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : TeacherProfileViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherprofileviewcontroller") as! TeacherProfileViewController
        destViewController.isEditableView = false
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    func showTeachersChat() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "TeacherChatViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
        
}
    
    func showTeachersSendMsg() {
        let alertController = UIAlertController(title: "Write message", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { alert -> Void in
           
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
        
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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

extension TeachersViewController{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faculties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeachersTableViewCell") as! TeachersTableViewCell
        cell.delegateTeachersMethods = self
        cell.displayDataFrom(teacher: faculties[indexPath.row])
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TeachersHeaderView") as! TeachersHeaderView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
}
