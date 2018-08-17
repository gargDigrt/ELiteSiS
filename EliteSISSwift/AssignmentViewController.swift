//
//  AssignmentViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    //IBOutlets
    @IBOutlet weak var searchBarAssignment: UISearchBar!
    @IBOutlet weak var assignmentTableView: UITableView!
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    //Variables
    var allAssignments = [Assignment]()
    var displayingAssignments = [Assignment]()
    
    //MARK:- View's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarAssignment.delegate = self
        
        getAssignmentReportForUser()
        getTableViewReady()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // WEB Service call
    func getAssignmentReportForUser() {
        ProgressLoader.shared.showLoader(withText: "Loading")
        guard let studentId  = UserDefaults.standard.string(forKey: "sis_studentid") else {return}
        
        WebServices.shared.getAssignmentList(studentID: studentId, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
                let assignmentArray = responseDict["value"].arrayValue
                for item in assignmentArray {
                    let assignment = Assignment(json: item)
                    self.allAssignments.append(assignment)
                }
                self.displayingAssignments = self.allAssignments
                self.assignmentTableView.reloadData()
                ProgressLoader.shared.hideLoader()
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "fetching dashboard error")
            }
        })
        
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
    
    @objc func downloadAssignment(btn:UIButton) {
        
        ProgressLoader.shared.showLoader(withText: "Downloading")
        let assignment = allAssignments[btn.tag]
        WebServices.shared.downloadAssignment(objectID: assignment.value!, completion: {(response, error) in
            ProgressLoader.shared.hideLoader()
            if error == nil, let responseDict = response {
                if responseDict["value"].arrayValue.count == 0 {
                    AlertManager.shared.showAlertWith(title: "Error!", message: "Assignment not found")
                }else{
                    AlertManager.shared.showAlertWith(title: "Assignment Downloaded!", message: "")
                }
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "fetching dashboard error")
            }
        })
    }
    
    @objc func showAssignmentDetails(btn:UIButton) {
        let alert = UIAlertController(title: "Assignment", message: allAssignments[btn.tag].name!, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dismissKeypad() {
        self.view.endEditing(true)
    }
    
    //MARK :- Button Actions
    
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
    
    // MARK:- Custom methods
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            tblViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
        
    }
    
    fileprivate func getTableViewReady() {
        assignmentTableView.sectionHeaderHeight = 60
        
        assignmentTableView.estimatedRowHeight = 50
        assignmentTableView.rowHeight = UITableViewAutomaticDimension
        
        assignmentTableView.register(UINib(nibName:"AssignmentTableViewCell", bundle: nil), forCellReuseIdentifier: "AssignmentTableViewCell")
        assignmentTableView.register(UINib(nibName:"AssignmentHeaderReusableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AssignmentHeaderReusableView")
    }
    
    //MARK:- Search bar methods
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let doneToolBar : UIToolbar = UIToolbar(frame: CGRect(x: 0 ,y: 0 ,width: UIScreen.main.bounds.width,height: 50))
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AssignmentViewController.dismissKeypad)))
        doneToolBar.items = items
        searchBar.inputAccessoryView = doneToolBar
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            displayingAssignments = allAssignments
        }else{
            let filteredAssignments  = allAssignments.filter{$0.name!.range(of: searchText, options: .caseInsensitive) != nil}
            displayingAssignments = filteredAssignments
        }
        assignmentTableView.reloadData()
    }
}

// MARK:- UITableview delegate and datasource
extension AssignmentViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingAssignments.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentHeaderReusableView") as! AssignmentHeaderReusableView
        
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AssignmentTableViewCell") as! AssignmentTableViewCell
        cell.displayData(dict: displayingAssignments[indexPath.row])
        cell.btnViewAssignment.tag = indexPath.row
        
        cell.btnViewAssignment.addTarget(self, action: #selector(AssignmentViewController.showAssignmentDetails(btn:)), for: .touchUpInside)
        cell.btnDownloadAssignment.addTarget(self, action: #selector(AssignmentViewController.downloadAssignment(btn:)), for: .touchUpInside)
        return cell
    }
    
}

