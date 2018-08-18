//
//  HealthReportViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 03/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit


class HealthReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblBloodGroup: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblRecommendations: UILabel!
    @IBOutlet weak var tblViewDetails: UITableView!
    var arrProperties = [String]()
    var arrValues = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewDetails.register(UINib(nibName:"ChapterStatusTableViewCell", bundle:nil), forCellReuseIdentifier: "ChapterStatusTableViewCell")
        tblViewDetails.separatorStyle = .none
        tblViewDetails.rowHeight = 50
        
        
        arrProperties = ["Vision Index","Behaviour Index","Body Mass Index","Cleanliness Index","Nutrition Index","Smile Index", "Hygiene Index"]
        arrValues = ["6/6","Good", "Normal", "Good", "Good", "Happy", "Good"]
        
        tblViewDetails.dataSource = self
        tblViewDetails.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterStatusTableViewCell") as! ChapterStatusTableViewCell
        cell.lblChapter.text = arrProperties[indexPath.row]
        cell.lblStatus.text = arrValues[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.lblChapter.font = UIFont.boldSystemFont(ofSize: 16.0)
        return cell
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
