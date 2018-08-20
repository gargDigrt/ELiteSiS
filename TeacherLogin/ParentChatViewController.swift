//
//  ParentChatViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import ALLoadingView

struct Faculty {
    let name: String
    let facultyID: String
    
    init(name:String, id: String) {
        self.name = name
        self.facultyID = id
    }
}

class ParentChatViewController: UIViewController {
    //  var dataSourceClassses = ["Maths Teacher", "Science Teacher", "English Teacher", "Hindi Teacher", "Geography Teacher", "History Teacher", "Dance Teacher", "Sports Teacher"]
    
    //IBOutlet
    @IBOutlet weak var viewClassSelection: UIView!
    @IBOutlet weak var lblSelectedClass: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textViewMsg: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var tblViewDiscussion: UITableView!
    
    //Variables
    var nameString:String!
    var dataSourceClassses = [String]()
    var dropDownStudents: DropDown!
    var myReciepentID:String = ""
    var arrMsgData = [String]()
    var faculties:[Faculty] = []
    
    //MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFacultyList()
        configureTableView()
        
        if nameString != nil {
            lblTeacherName.text = nameString
        }
        
        lblSelectedClass.text = "Select Teacher"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- Custom methods
    fileprivate func configureTableView() {
        //lblTeacherName.layer.borderWidth = 1.0
        //lblTeacherName.layer.borderColor = UIColor.black.cgColor
        tblViewDiscussion.separatorStyle = .none
        tblViewDiscussion.register(UINib(nibName:"ReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverTableViewCell")
        tblViewDiscussion.rowHeight = UITableViewAutomaticDimension
        tblViewDiscussion.delegate = self
        tblViewDiscussion.dataSource = self
        textViewMsg.delegate = self
    }
    
    func configureDropDown(){
        dropDownStudents = DropDown()
        
        // The view to which the drop down will appear on
        dropDownStudents.anchorView = self.viewClassSelection
        dropDownStudents.dataSource = self.dataSourceClassses
        dropDownStudents.selectRow(at: 0)
        dropDownStudents.selectionAction = { [unowned self] (index: Int, item: String) in
            // Handle dropdown selection
            let facultyName = self.faculties[index].name
            self.lblSelectedClass.text = facultyName
            let facultyId = self.faculties[index].facultyID
            self.getChatMessageForFaculty(fID: facultyId)
        }
        
    }
    
    func showStudentsClass(classSelected: String) {
        self.lblSelectedClass.text = classSelected
        
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            textViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            textViewBottomConstraint.constant = 15
        }
        
    }
//    func configDropDown(){
//        guard let classSession = UserDefaults.standard.object(forKey: "_sis_currentclasssession_value") as? String else { return }
//
//        // call API here
//        ProgressLoader.shared.showLoader(withText: "Please wait...")
//
//        WebServices.shared.getLessionPlansFor(classSession: classSession, completion: { (response, error) in
//
//            if error == nil, let responseDict = response {
//                print("Responce...........\(responseDict)")
//
//                let subjects = responseDict["value"].arrayValue
//
//                for subject in subjects {
//                    let SubjectName = subject["new_subject"]["sis_name"].stringValue
//                    let FacultyName = subject["new_faculty"]["sis_name"].stringValue
//                    print("\(FacultyName), \(SubjectName)")
//
//                    self.dataSourceClassses.append("\(FacultyName), \(SubjectName)")
//                }
//
//                ProgressLoader.shared.hideLoader()
//                print(self.dataSourceClassses)
//
//
//
//                // The list of items to display. Can be changed dynamically
//                self.dropDownStudents.dataSource = self.dataSourceClassses
//
//                self.dropDownStudents.selectionAction = { [unowned self] (index: Int, item: String) in
//                    self.showStudentsClass(classSelected: item)
//                }
//            }
//            else{
//                ProgressLoader.shared.hideLoader()
//                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
//                debugPrint(error?.localizedDescription ?? "Getting user profile error")
//            }
//        })
//        // calling new API
//    }
    
    //MARK:- Web service calls
    func getFacultyList() {
        let sectionId = UserDefaults.standard.string(forKey: "_sis_section_value")
        WebServices.shared.getFacultyList(sectionID: sectionId!, completion: {(response, error) in
            
            if error == nil, let responseDict = response {
               
             let facultyData = responseDict.arrayValue
                self.dataSourceClassses.removeAll()
                for item in facultyData {
                    let name = item["FacultyName"].stringValue
                    self.dataSourceClassses.append(name)
                    let id = item["FacultyContactID"].stringValue
                    let faculty = Faculty(name: name, id: id)
                    self.faculties.append(faculty)
                }
                self.configureDropDown()
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }

    func getChatMessageForFaculty(fID: String)  {
        
        let senderid = UserDefaults.standard.string(forKey: "_sis_studentname_value")
        WebServices.shared.getChatMessage(senderID: senderid!, RecipientId: fID, CreatedOn: "nodate", completion: {(response, error) in
            if error == nil, let responseDict = response {
                
                self.arrMsgData.removeAll()
                let msgData = responseDict["value"].arrayValue
                for msg in msgData {
                    let msgText = msg["new_message"].stringValue
                    self.arrMsgData.append(msgText)
                }
                self.tblViewDiscussion.reloadData()
                
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }

    
    //MARK:- Button Actions
    @IBAction func btnSelectClassClick(_ sender: Any) {
        if dropDownStudents.isHidden{
            dropDownStudents.show()
            hideSideMenuView()
        }
        else{
            dropDownStudents.hide()
        }
    }
    
    //MARK:- Selector methods
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    
    //MARK:- Button actions
    @IBAction func btnSendClicked(_ sender: UIButton) {
        if textViewMsg.text != nil && textViewMsg.text.count != 0 {
            arrMsgData.append(textViewMsg.text!)
            tblViewDiscussion.reloadData()
            tblViewDiscussion.scrollToRow(at: IndexPath(row:arrMsgData.count - 1 , section: 0), at: .bottom, animated: false)
            textViewMsg.text = ""
        }
        
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
extension ParentChatViewController:  UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell") as! ReceiverTableViewCell
        cell.lblMsg.text = arrMsgData[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }

}

//MARK:- UITextView Delegate 
extension ParentChatViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}


