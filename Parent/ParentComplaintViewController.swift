//
//  ParentComplaintViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ParentComplaintViewController: UIViewController,UITextViewDelegate {
@IBOutlet weak var txtViewMsg: UITextView!
    @IBOutlet weak var txtFieldSubject: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtViewMsg.delegate = self;
        txtViewMsg.text = "Message"
        txtViewMsg.textColor = UIColor.lightGray
        let color = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        txtViewMsg.layer.borderColor = color
        txtViewMsg.layer.borderWidth = 1
        txtViewMsg.layer.cornerRadius = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
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

    
    @IBAction func okClicked(_ sender: Any) {
        
        if  (txtFieldSubject.text!.count) > 0{
            if  (txtViewMsg.text!.count) > 0{
                if  (txtViewMsg.text! == "Message"){
                    let alert = UIAlertController(title: "Alert", message: "Message field can't be left Blank", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    
                    let alert = UIAlertController(title: "Success!", message: "Complaint sent successfully!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Message field can't be left Blank", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }else{
            
            let alert = UIAlertController(title: "Alert", message: "Subject field can't be left Blank", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
        }
}
}
