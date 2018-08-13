
//
//  LoginViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftHash
import Alamofire
import SwiftyJSON

enum LoginUserType: String {
    case STUDENT = "S"
    case TEACHER = "E"
    case PARENT = "G"
}


class LoginViewController: UIViewController, LoginButtonDelegate {
    
    //IBOutlets
    @IBOutlet weak var tblViewLogin: UITableView!
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    //Variables
    var selectedLogin = LoginUserType.TEACHER.rawValue
    var btnRememberTick:UIButton!
    var boolRemember = false
    
    
    //MARK:- View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewLogin.separatorStyle = .none
        tblViewLogin.register(UINib(nibName: "LogoTableViewCell", bundle:nil), forCellReuseIdentifier: "LogoTableViewCell")
        tblViewLogin.register(UINib(nibName: "LoginCredentialsTableViewCell", bundle:nil), forCellReuseIdentifier: "LoginCredentialsTableViewCell")
        tblViewLogin.register(UINib(nibName: "ForgotPasswordTableViewCell", bundle:nil), forCellReuseIdentifier: "ForgotPasswordTableViewCell")
        tblViewLogin.register(UINib(nibName: "ButtonWithBgTableViewCell", bundle:nil), forCellReuseIdentifier: "ButtonWithBgTableViewCell")
        
        
        tblViewLogin.delegate = self
        tblViewLogin.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if((self.navigationController) != nil){
            self.navigationController?.dismiss(animated: false, completion:nil)
            
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
    
    @objc func rememberMeClicked() {
        if boolRemember {
            boolRemember = false
            btnRememberTick.setImage(nil, for: .normal)
        } else {
            boolRemember = true
            btnRememberTick.setImage(UIImage(named:"ic_done"), for: .normal)
        }
    }
    
    @objc func goToForgotPwdScreen() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController
        {
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    //MARK:- Custom methods
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            tblViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
    }
    
    /// This function is used to get the user name entered by user
    ///
    /// - Returns: User name as string
    func getUserName()->String {
        let userNameCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        let LoginNameArr =  userNameCell.textField.text?.components(separatedBy: "|")
        // let size = LoginNameArr?.count
        var requiredLoginType = userNameCell.textField.text
        
        if LoginNameArr?.count ?? 0 > 1  {
            requiredLoginType = LoginNameArr![1]
            return requiredLoginType!
        } else {
            return requiredLoginType!
        }
    }
}

//MARK: - LoginButtonDelegate

extension LoginViewController {
    
    func buttonClicked() {
        
        let passwordCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        // return passwordCell.textField.text ?? ""
        let userNameCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        
        guard let username = userNameCell.textField.text, username != ""  else {
            AlertManager.shared.showAlertWith(title: "Alert", message: "User Name cannot be left blank")
            return
            
        }
        guard let password = passwordCell.textField.text, password != ""  else {
            AlertManager.shared.showAlertWith(title: "Alert", message: "Password can't be left Blank")
            return
            
        }
        
        ProgressLoader.shared.showLoader(withText: "Login! Please wait...")
        
        self.selectedLogin = self.getUserName()
        UserDefaults.standard.set(self.selectedLogin, forKey: "selectedLogin")
        
        WebServices.shared.loginUserWith(username: username, password: password, completion: {(response, error ) in
            
            if error == nil, let responseDict = response {
                if(responseDict["@odata.count"] == 1){
                    
                    print(responseDict["value"] [0]["_sis_registration_value"])
                    
                    let sisName = responseDict["value"][0]["sis_name"].stringValue
                    UserDefaults.standard.set(sisName, forKey: "sis_name")
                    
                    let loginRole = responseDict["value"] [0]["new_rolecode"].stringValue
                    //                    print(loginRole)
                    let regId = responseDict["value"] [0]["_sis_registration_value"].stringValue
                    //                    print(regId)
                    
                    ProgressLoader.shared.hideLoader()
                    
                    UserDefaults.standard.set(regId, forKey: "_sis_registration_value")
                    UserDefaults.standard.set(loginRole, forKey: "new_rolecode")
                    if(loginRole == "1") {
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "myNavi") as? MyNavigationController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                    } else if(loginRole == "2"){
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeacherNavi") as? TeacherNavigationController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    } else if(loginRole == "3") {
                        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ParentNavi") as? ParentViewController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }else{
                    ProgressLoader.shared.hideLoader()
                    AlertManager.shared.showAlertWith(title: "Login Failed!", message: "Please check your Username and Password")
                }
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error Occured!", message: "Please try after some time")
            }
        })
    }
    
}

// MARK:- UITableView Delegates

extension LoginViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
            
        case 1,2:
            return 70
            
        case 3:
            return 50
            
        case 4:
            return 100
            
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
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = "Enter username"
            cellUserTxtFld.textField.text = "SISK12|S|1819|1173"//LoginUserType.PARENT.rawValue
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_user.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
        case 2:
            let cellPassword = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellPassword.backgroundColor = UIColor.clear
            cellPassword.textField.placeholder = "Enter password"
            cellPassword.textField.text = "apar@1234"
            cellPassword.textField.isSecureTextEntry = true
            cellPassword.selectionStyle = .none
            //cellPassword.imgView.image = UIImage(named: "ic_lock.png")
            cellPassword.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellPassword.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellPassword
            
        case 3:
            let cellForgotPwd = tableView.dequeueReusableCell(withIdentifier: "ForgotPasswordTableViewCell") as! ForgotPasswordTableViewCell
            cellForgotPwd.backgroundColor = UIColor.clear
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.goToForgotPwdScreen))
            cellForgotPwd.lblForgotPassword.addGestureRecognizer(tapGesture)
            
            let tapgestureRememberMe = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.rememberMeClicked))
            cellForgotPwd.lblRememberMe.addGestureRecognizer(tapgestureRememberMe)
            cellForgotPwd.btnRememberMe.addTarget(self, action: #selector(LoginViewController.rememberMeClicked), for: .touchUpInside)
            cellForgotPwd.selectionStyle = .none
            if btnRememberTick == nil {
                btnRememberTick = cellForgotPwd.btnRememberMe
            }
            return cellForgotPwd
            
        case 4:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonWithBgTableViewCell") as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            cellLoginBtn.delegate = self
            cellLoginBtn.btnInCell.setTitle("Login", for: .normal)
            
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
            
        default:
            return UITableViewCell()
        }
    }
}
