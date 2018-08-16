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

class ParentChatViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextViewDelegate {
    //  var dataSourceClassses = ["Maths Teacher", "Science Teacher", "English Teacher", "Hindi Teacher", "Geography Teacher", "History Teacher", "Dance Teacher", "Sports Teacher"]
    var dataSourceClassses = [String]()
    var selectedClass = "Maths Teacher"
    var dropDownStudents: DropDown!
    @IBOutlet weak var viewClassSelection: UIView!
    @IBOutlet weak var lblSelectedClass: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textViewMsg: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTeacherName: UILabel!
    var nameString:String!
    @IBOutlet weak var tblViewDiscussion: UITableView!
    var arrMsgData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDropDown()
        //lblTeacherName.layer.borderWidth = 1.0
        //lblTeacherName.layer.borderColor = UIColor.black.cgColor
        tblViewDiscussion.separatorStyle = .none
        tblViewDiscussion.register(UINib(nibName:"ReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverTableViewCell")
        tblViewDiscussion.rowHeight = UITableViewAutomaticDimension
        tblViewDiscussion.delegate = self
        tblViewDiscussion.dataSource = self
        textViewMsg.delegate = self
        
        if nameString != nil {
            lblTeacherName.text = nameString
        }
        
        // Do any additional setup after loading the view.
    }
    
    func configDropDown(){
        dropDownStudents = DropDown()
        
        // The view to which the drop down will appear on
        dropDownStudents.anchorView = self.viewClassSelection
        // call API here
        ProgressLoader.shared.showLoader(withText: "Please wait...")
        guard let ClassSession = UserDefaults.standard.object(forKey: "_sis_currentclasssession_value") as? String else { return }
        WebServices.shared.ChooseTeacherForDiscussion(classSession: ClassSession, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                print("Responce...........\(responseDict)")
                
                //  for dic in responseDict["value"] {
                for index in 0..<4 {
                    let SubjectName = responseDict["value"][index]["new_subject"]["sis_name"].stringValue
                    let FacultyName = responseDict["value"][index]["new_faculty"]["sis_name"].stringValue
                    print("\(FacultyName), \(SubjectName)")
                    print(SubjectName)
                    self.dataSourceClassses.append("\(FacultyName), \(SubjectName)")
                }
                ProgressLoader.shared.hideLoader()
                print(self.dataSourceClassses)
                // The list of items to display. Can be changed dynamically
                self.dropDownStudents.dataSource = self.dataSourceClassses
                
                self.dropDownStudents.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.showStudentsClass(classSelected: item)
                }
            }
            else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
        
    }
    
    func showStudentsClass(classSelected: String){
        self.lblSelectedClass.text = classSelected
        self.selectedClass = classSelected
        
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
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        if textViewMsg.text != nil && textViewMsg.text.count != 0 {
            arrMsgData.append(textViewMsg.text!)
            tblViewDiscussion.reloadData()
            tblViewDiscussion.scrollToRow(at: IndexPath(row:arrMsgData.count - 1 , section: 0), at: .bottom, animated: false)
            textViewMsg.text = ""
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            textViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            textViewBottomConstraint.constant = 15
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

