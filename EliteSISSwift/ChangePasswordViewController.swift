//
//  ChangePasswordViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblViewChangePwd: UITableView!
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewChangePwd.separatorStyle = .none
        tblViewChangePwd.register(UINib(nibName: "LogoTableViewCell", bundle:nil), forCellReuseIdentifier: "LogoTableViewCell")
        tblViewChangePwd.register(UINib(nibName: "ButtonWithBgTableViewCell", bundle:nil), forCellReuseIdentifier: "ButtonWithBgTableViewCell")
        tblViewChangePwd.register(UINib(nibName: "LoginCredentialsTableViewCell", bundle:nil), forCellReuseIdentifier: "LoginCredentialsTableViewCell")
        tblViewChangePwd.register(UINib(nibName: "SimpleLabelTableViewCell", bundle:nil), forCellReuseIdentifier: "SimpleLabelTableViewCell")
        
        tblViewChangePwd.delegate = self
        tblViewChangePwd.dataSource = self
        
        // Do any additional setup after loading the view.
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
            tblViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
            
        case 1:
            return UITableViewAutomaticDimension
            
        case 2,3,4:
            return 60
            
        case 5:
            return 70
            
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellLogo = tableView.dequeueReusableCell(withIdentifier: "LogoTableViewCell") as! LogoTableViewCell
            cellLogo.backgroundColor = UIColor.clear
            cellLogo.selectionStyle = .none
            return cellLogo
            
        case 1:
            let cellDesc = tableView.dequeueReusableCell(withIdentifier: "SimpleLabelTableViewCell") as! SimpleLabelTableViewCell
            cellDesc.lblContent.text = "Create a new password that is at least 6 Characters long. A strong password has a combination  of letters, digit and punctuation marks."
            cellDesc.lblContent.font = UIFont.systemFont(ofSize: 15)
            cellDesc.backgroundColor = UIColor.clear
            cellDesc.selectionStyle = .none
            return cellDesc
            
        case 2:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = "Enter old password"
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
        case 3:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = "Enter new password"
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
        case 4:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = "Confirm new password"
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
            
        case 5:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonWithBgTableViewCell") as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            //            cellLoginBtn.protocolButtonClickImplementation = self
            cellLoginBtn.btnInCell.setTitle("SUBMIT", for: .normal)
            cellLoginBtn.delegate = self
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
            
        default:
            return UITableViewCell()
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
    
    func onSubmitClick(){
        let oldPassword = (self.tblViewChangePwd.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell).textField.text
        let newPassword = self.tblViewChangePwd.cellForRow(at: IndexPath(row: 3, section: 0)) as! LoginCredentialsTableViewCell
        let confirmPassword = self.tblViewChangePwd.cellForRow(at: IndexPath(row: 4, section: 0)) as! LoginCredentialsTableViewCell
        
        if (validPassword(newPassword: newPassword.textField.text ?? "", confirmPassword: confirmPassword.textField.text ?? "")){
            print("Password can be submitted")
            let alert = UIAlertController(title: "Done", message: "Password changed successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else{
            print("Password can't be submitted")
        }
    }
    
    func validateOldPassword(){
        
    }
    
    @IBAction func submitClicked(_ sender: Any) {
    }
    
    func first(){
        print("Hello World")
    }
    
    func validPassword(newPassword: String, confirmPassword: String) -> Bool {
        
        if  (newPassword.count) < 6{
            print("Please enter more than 5 characters in New Password Field")
            
            let alert = UIAlertController(title: "Alert", message: "Please enter more than 5 characters in New Password Field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
            return false
        }
        
        if(newPassword != confirmPassword ){
            let alert = UIAlertController(title: "Alert", message: "New password and confirm password don't match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        //        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //        sideMenuController()?.setContentViewController(destViewController)
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
}


extension ChangePasswordViewController: LoginButtonDelegate{
    func buttonClicked() {
        self.onSubmitClick()
    }
}

