//
//  ForgotPasswordViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 13/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoginButtonDelegate, UITextFieldDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.separatorStyle = .none
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: "LogoTableViewCell", bundle:nil), forCellReuseIdentifier: "LogoTableViewCell")
        tblView.register(UINib(nibName: "SimpleLabelTableViewCell", bundle:nil), forCellReuseIdentifier: "SimpleLabelTableViewCell")
        tblView.register(UINib(nibName: "ButtonWithBgTableViewCell", bundle:nil), forCellReuseIdentifier: "ButtonWithBgTableViewCell")
        tblView.register(UINib(nibName: "LoginCredentialsTableViewCell", bundle:nil), forCellReuseIdentifier: "LoginCredentialsTableViewCell")
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
       
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
            
        case 1:
            return UITableViewAutomaticDimension

        case 2:
            return 60

        case 3:
            return 90
            
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
            cellDesc.lblContent.text = "Enter your mobile number and we will send you OTP to reset password."
            cellDesc.lblContent.font = UIFont.systemFont(ofSize: 15)
            cellDesc.backgroundColor = UIColor.clear
            cellDesc.selectionStyle = .none
            return cellDesc
            
        case 2:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: "LoginCredentialsTableViewCell") as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = "Enter Mobile number"
            cellUserTxtFld.textField.keyboardType = .numberPad
            cellUserTxtFld.selectionStyle = .none
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_user.png")!.withRenderingMode(.alwaysTemplate)
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            
            let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
            numberToolbar.barStyle = .default
            numberToolbar.items = [
                UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ForgotPasswordViewController.closeKeyPad))
            ]
            numberToolbar.sizeToFit()
            cellUserTxtFld.textField.inputAccessoryView = numberToolbar
            
            return cellUserTxtFld
            
        case 3:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: "ButtonWithBgTableViewCell") as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            cellLoginBtn.delegate = self
            cellLoginBtn.btnInCell.setTitle("Submit", for: .normal)
            
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
    
    @IBAction func btnBackClicked() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeKeyPad() {
        self.view.endEditing(true)
    }
    
    func buttonClicked() {
        
        let userNameCell = self.tblView.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        print (userNameCell.textField.text!)
        if validate(value: userNameCell.textField.text!){
            let alert = UIAlertController(title: "Success!", message: "OTP sent on provided Phone number", preferredStyle: .alert)
            //let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }else{
            print("Invalid Number")
            let alert = UIAlertController(title: "Error!", message: "Please enter a valid Mobile number", preferredStyle: .alert)
            let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.alert
     
        // Pass the selected object to the new view controller.
    }
    */
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@",PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    

}
