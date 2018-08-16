//
//  AssignmentViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarAssignment: UISearchBar!
    @IBOutlet weak var tblViewAssignment: UITableView!
    var arrAssignments = [[String:String]]()
    var arrResult = [[String:String]]()
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callAssignment()
        tblViewAssignment.separatorStyle = .none
        
        tblViewAssignment.delegate = self
        tblViewAssignment.dataSource = self
        searchBarAssignment.delegate = self
        var dictMaths = [String:String]()
        dictMaths["desc"] = "Maths - Write 1 - 10"
        dictMaths["issueDate"] = "5-Jan-2018"
        dictMaths["submitDate"] = "4-Nov-2018"
        
        var dictEng = [String:String]()
        dictEng["desc"] = "English - Write A - Z"
        dictEng["issueDate"] = "5-Jan-2018"
        dictEng["submitDate"] = "20-Nov-2018"
        
        var dictArt = [String:String]()
        dictArt["desc"] = "Art - Draw Flower"
        dictArt["issueDate"] = "5-Jan-2018"
        dictArt["submitDate"] = "14-Dec-2018"
        
        var dictLearn = [String:String]()
        dictLearn["desc"] = "Learn Rhyme - Twinkle Twinkle"
        dictLearn["issueDate"] = "7-Jan-2018"
        dictLearn["submitDate"] = "4-Nov-2018"
        
        arrAssignments.append(dictMaths)
        arrAssignments.append(dictEng)
        arrAssignments.append(dictArt)
        arrAssignments.append(dictLearn)
        
        arrResult.append(dictMaths)
        arrResult.append(dictEng)
        arrResult.append(dictArt)
        arrResult.append(dictLearn)
        
        tblViewAssignment.sectionHeaderHeight = 60
        
        tblViewAssignment.estimatedRowHeight = 50
        tblViewAssignment.rowHeight = UITableViewAutomaticDimension
        
        tblViewAssignment.register(UINib(nibName:"AssignmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignmentTableViewCell")
        tblViewAssignment.register(UINib(nibName:"AssignmentHeaderReusableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AssignmentHeaderReusableView")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        return arrAssignments.count
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentHeaderReusableView") as! AssignmentHeaderReusableView
        
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentTableViewCell") as! AssignmentTableViewCell
        cell.lblDescription.text = arrAssignments[indexPath.row]["desc"]
        cell.lblIssueDate.text = arrAssignments[indexPath.row]["issueDate"]
        cell.lblSubmitDate.text = arrAssignments[indexPath.row]["submitDate"]
        cell.btnViewAssignment.tag = indexPath.row
        cell.btnViewAssignment.addTarget(self, action: #selector(AssignmentViewController.showAssignmentDetails(btn:)), for: .touchUpInside)
        cell.btnDownloadAssignment.addTarget(self, action: #selector(AssignmentViewController.downloadAssignment(btn:)), for: .touchUpInside)
        return cell
    }
    @objc func downloadAssignment(btn:UIButton) {
        let alert = UIAlertController(title: "Assignment Downloaded!", message: nil, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showAssignmentDetails(btn:UIButton) {
        let alert = UIAlertController(title: "Assignment", message: arrAssignments[btn.tag]["desc"], preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let doneToolBar : UIToolbar = UIToolbar(frame: CGRect(x: 0 ,y: 0 ,width: UIScreen.main.bounds.width,height: 50))
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AssignmentViewController.dismissKeypad)))
        doneToolBar.items = items
        searchBar.inputAccessoryView = doneToolBar
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrAssignments = arrResult.filter{$0["desc"]?.range(of: searchText, options: .caseInsensitive) != nil}
        
        if searchText.count == 0 {
            arrAssignments = arrResult
        }
        tblViewAssignment.reloadData()
    }
    
    @objc func dismissKeypad() {
        self.view.endEditing(true)
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
    
    
    
    @IBAction func toggleSideMenuBtn(_ sender: UIBarButtonItem) {
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
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        else if(selectedLogin == "G"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "parentdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        hideSideMenuView()
    }
    
    func callAssignment()  {
        ProgressLoader.shared.showLoader(withText: "Please wait... ")
        guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else { return }
        WebServices.shared.showAssignmentList(studentID: regID, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                print("Responce...........\(responseDict)")
                
                //                self.arrHolidayList = responseDict["value"].arrayObject as! [[String : Any]]
                //                print(self.arrHolidayList)
                //                DispatchQueue.main.async {
                //                    self.tblViewHolidayList.reloadData()
                //                }
                ProgressLoader.shared.hideLoader()
            }
            else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error Occured!", message: "Please try after some time")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
        
    }
}

