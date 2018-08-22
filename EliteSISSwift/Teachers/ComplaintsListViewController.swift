//
//  ComplaintsListViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 13/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ALLoadingView

class ComplaintsListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblViewComplaints: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenuIcon: UIButton!
    var arrTupleComplaints : [(String,String,String)]?
     var arrComplaintList = [[String: Any]]()
    let regid = UserDefaults.standard.string(forKey: "_sis_registration_value")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        arrTupleComplaints = [("Mr. R.S. Sharma", "Sana", "Bullying of Paavini towards Sana"),("Mr .A.K. Shukla", "Pavaini", "Medical Attention"),("Mrs. Seema", "Ayush", "Followup after Lunch")]
        
        tblViewComplaints.register(UINib(nibName:"ComplaintsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ComplaintsHeaderView")
        tblViewComplaints.register(UINib(nibName:"ComplaintsListTableViewCell", bundle:nil), forCellReuseIdentifier: "ComplaintsListTableViewCell")
        tblViewComplaints.sectionHeaderHeight = 60
        tblViewComplaints.rowHeight = UITableViewAutomaticDimension
        tblViewComplaints.delegate = self
        tblViewComplaints.dataSource = self
        tblViewComplaints.separatorStyle = .none
self .callForComplaintListData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrComplaintList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ComplaintsHeaderView") as! ComplaintsHeaderView
        
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComplaintsListTableViewCell") as! ComplaintsListTableViewCell
        cell.lblParent.text = self.arrComplaintList [indexPath.row]["Customer"] as? String
        let strFullStudentName = self.arrComplaintList [indexPath.row]["Student"] as? String //[self.arrComplaintList [indexPath.row]["Student"]].components(separatedBy: "|")
        let arrStudentNameArr = strFullStudentName?.components(separatedBy: "(")
        cell.lblStudent.text = arrStudentNameArr! [0]
        //cell.lblStudent.text = self.arrComplaintList [indexPath.row]["Student"] as? String
        cell.lblSubject.text = self.arrComplaintList [indexPath.row]["Title"] as? String
        cell.backgroundColor = UIColor.clear
        
        cell.btnAction.tag = indexPath.row
        let strtocomp = self.arrComplaintList [indexPath.row]["Status"] as? Int
        if strtocomp == 1 {
            let image = UIImage(named: "ic_done")
            cell.btnAction.setImage(image, for: .normal)
            
        }else{
            cell.btnAction.addTarget(self, action: #selector(ComplaintsListViewController.goToComplaintDetailVC(sender:)), for: .touchUpInside)
            
        }
        
        cell.selectionStyle = .none
        return cell
        
    }
    
    @objc func goToComplaintDetailVC(sender:UIButton) {
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "ComplaintDetailViewController") as! ComplaintDetailViewController
        vc.strSubject = self.arrComplaintList [sender.tag]["Title"] as? String
        vc.strCaseId = self.arrComplaintList [sender.tag]["CaseId"] as? String
        vc.strCaseDesc = self.arrComplaintList [sender.tag]["Description"] as? String
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnMenuClicked(_ sender: UIButton) {
        toggleSideMenuView()
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
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
    
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func callForComplaintListData(){
        self .showLoader()
        DispatchQueue.global().async {
            
            let stringComplaintDataCall = "http://43.224.136.81:5015/SIS/Compliance/" + self.regid
            print (stringComplaintDataCall)
            let encodedString = stringComplaintDataCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
            print(encodedString!)
            Alamofire.request(encodedString!).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    self .hideLoader()
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    //  self.arrHolidayList = swiftyJsonVar["value"]
                    print(swiftyJsonVar ["value"])
//                    self.arrComplaintList = swiftyJsonVar.arrayObject as! [[String : Any]]
                    print(self.arrComplaintList [0])
                    DispatchQueue.main.async{
                        //put your code here
                        
                        self.tblViewComplaints.reloadData()
                    }
                    
                    
                }else{
                    self .hideLoader()
                    let alert = UIAlertController(title: "Error Occured!", message: "Please try after some time", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    func showLoader(){
        
        // https://www.cocoacontrols.com/controls/alloadingview
        
        ALLoadingView.manager.resetToDefaults()
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.animationDuration = 1.0
        ALLoadingView.manager.itemSpacing = 30.0
        ALLoadingView.manager.messageText = "Loading...."
        ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
        
    }
    func hideLoader(){
        
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        ALLoadingView.manager.resetToDefaults()
        
    }
    
}
