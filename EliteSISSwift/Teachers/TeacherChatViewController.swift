//
//  TeacherChatViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 26/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class TeacherChatViewController: UIViewController {
    
    //IBoutlet
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textViewMsg: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var tblViewDiscussion: UITableView!
    
    // VAriables
    var arrMsgData = [JSON]()
    var facultyID: String!
    var facultyName: String?
    
    //MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        self.getChatMessageForFaculty(fID: facultyID)
        textViewMsg.delegate = self
        
        lblTeacherName.layer.borderWidth = 1.0
        lblTeacherName.layer.borderColor = UIColor.black.cgColor
        if facultyName != nil {
            lblTeacherName.text = facultyName
        }else{
            lblTeacherName.text = "Teacher"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK:- Custom method
    fileprivate func configureTableView() {
        tblViewDiscussion.separatorStyle = .none
        tblViewDiscussion.register(UINib(nibName:"ReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceiverTableViewCell")
        tblViewDiscussion.rowHeight = UITableViewAutomaticDimension
        tblViewDiscussion.delegate = self
        tblViewDiscussion.dataSource = self
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            textViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            textViewBottomConstraint.constant = 15
        }
        
    }
    
    func getChatMessageForFaculty(fID: String)  {
        
        guard let senderid = UserDefaults.standard.string(forKey: "_sis_studentname_value") else { return}
        ProgressLoader.shared.showLoader(withText: "")
        WebServices.shared.getChatMessage(senderID: senderid, recipientId: fID, createdOn: "nodate", completion: {(response, error) in
            if error == nil, let responseDict = response {
                
                self.arrMsgData.removeAll()
                let msgData = responseDict["value"].arrayValue
                for msg in msgData {
                    self.arrMsgData.append(msg)
                }
                DispatchQueue.main.async {
                    self.tblViewDiscussion.reloadData()
                    self.scrollToBottom()
                    ProgressLoader.shared.hideLoader()
                }
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting faculty chat error")
            }
        })
    }
    
    func sendNewMessage(){
        guard let msg = textViewMsg.text, msg != "" else { return }
        guard let senderid = UserDefaults.standard.string(forKey: "_sis_studentname_value") else { return}
        guard let recipentID = facultyID  else { return }
        
        ProgressLoader.shared.showLoader(withText: "")
        WebServices.shared.sendNewMessage(text: msg, senderID: senderid, RecipientId: recipentID, completion: {(success , error) in
            if error == nil {
                if success{
                    self.getChatMessageForFaculty(fID: recipentID)
                }else{
                    AlertManager.shared.showAlertWith(title: "Opps!", message: "Message couldn't sent")
                }
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Sending new message error")
            }
            ProgressLoader.shared.hideLoader()
        })
    }
    
    func scrollToBottom(){
        guard arrMsgData.count != 0 else {return}
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrMsgData.count - 1,section: 0)
            self.tblViewDiscussion.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    //MARK:- Selector method
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    //MARK:- Action methods
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        //        if textViewMsg.text != nil && textViewMsg.text.count != 0 {
        //            arrMsgData.append(textViewMsg.text!)
        //            tblViewDiscussion.reloadData()
        //            tblViewDiscussion.scrollToRow(at: IndexPath(row:arrMsgData.count - 1 , section: 0), at: .bottom, animated: false)
        //            textViewMsg.text = ""
        //        }
        sendNewMessage()
        textViewMsg.text = ""
        
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
            self.navigationController?.popViewController(animated: true)
            //            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
            //            sideMenuController()?.setContentViewController(destViewController)
        }
        else if(selectedLogin == "G"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        hideSideMenuView()
    }
}

//MARK:- UITextView delegates

extension TeacherChatViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

//MARK:- UItableView delegates and Datasource

extension TeacherChatViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell") as! ReceiverTableViewCell
        let msgData = arrMsgData[indexPath.row]
        cell.textLabel?.text = msgData["new_message"].stringValue
        if facultyID == msgData["_new_recipient_value"].stringValue {
            cell.textLabel?.textAlignment = .right
            cell.textLabel?.textColor = .blue
        }else{
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = .black
        }
        return cell
    }
    
    
}
