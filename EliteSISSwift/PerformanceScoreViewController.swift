//
//  PerformanceScoreViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import Charts
import DropDown
import SwiftyJSON


class PerformanceScoreViewController: UIViewController{
    
    //IBOutlet
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var graphChart: LineChartView!
    @IBOutlet weak var viewChart: UIView!
    @IBOutlet var currentProgress: KDCircularProgress!
    @IBOutlet var currentProgressLabel: UILabel!
    @IBOutlet var overallProgress: KDCircularProgress!
    @IBOutlet var overallProgressLabel: UILabel!
    @IBOutlet weak var segmentedControlPerformanceScore: UISegmentedControl!
    
    @IBOutlet weak var tblViewScore: UITableView!
    @IBOutlet weak var viewScore: UIView!
    @IBOutlet weak var lblGrade: UILabel!
    @IBOutlet weak var viewOptions: UIView!
    @IBOutlet weak var lblSelectedOption: UILabel!
    
    //Variables
    var dropDownClasses: DropDown!
    let numbers = [60, 80, 92, 70, 77]
    var exams = ["FA1", "SA1", "FA2", "SA2", "Final"]
    var pickerData: [String] = [String]()
    var arrScoreData = [(String,String,String,String)]()
    var resultPercentage = Int()
    
    //MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateGraph()
        getPerformanceList()
        configureTableView()
        
        segmentedControlPerformanceScore.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        
        self.onCategoryChange(withCategoryIndex: 0)
//        self.lblSelectedOption.text = self.pickerData[0]
    }
    
    //MARK:- Selector methods
    
    @objc func segmentSelected(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        if index == 0 {
            displayCircularProgress()
            viewScore.isHidden = true
            viewChart.isHidden = false
        } else {
            tblViewScore.reloadData()
            viewScore.isHidden = false
            viewChart.isHidden = true
        }
    }
    
    //MARK:- Custom methods
    
    fileprivate func configureTableView() {
        tblViewScore.sectionHeaderHeight = 55
        tblViewScore.sectionFooterHeight = 55
        
        tblViewScore.register(UINib(nibName:"AssignmentHeaderReusableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "AssignmentHeaderReusableView")
        tblViewScore.register(UINib(nibName:"ScoreTableViewCell", bundle:nil), forCellReuseIdentifier: "ScoreTableViewCell")
        
        tblViewScore.separatorStyle = .none
        tblViewScore.delegate = self
        tblViewScore.dataSource = self
    }
    
    func getPerformanceList() {
        let studentId = UserDefaults.standard.string(forKey: "sis_studentid")
        let sessionId = UserDefaults.standard.string(forKey: "_sis_currentclasssession_value")
        let sectionId = UserDefaults.standard.string(forKey: "_sis_section_value")
        
        WebServices.shared.getPerformancelistFor(studentID: studentId!, sessionID: sessionId!, sectionID: sectionId!, completion: { (response, error) in
            
            if error == nil, let respondeDict = response {
                self.resultPercentage = respondeDict["value"][0]["sis_resultsinpercentage"].intValue
                let marksID = respondeDict["value"][0]["sis_classsessionwisemarksid"].stringValue
                UserDefaults.standard.set(marksID, forKey: "sis_classsessionwisemarksid")
                self.displayCircularProgress()
                
                // Set exam picker data
                let examName = respondeDict["value"][0]["examtype_x002e_sis_name"].stringValue
                let examAcronym = examName.getAcronyms().uppercased()
                self.pickerData.removeAll()
                self.pickerData.append(examAcronym)
                self.configDropDown()
                //getStudyProgress
                WebServices.shared.getStudyProgress(marksID: marksID, completion: { (response, error) in
                    if error == nil, let respondeDict = response {
                        self.displayStudyProgress(withDict: respondeDict)
                    }else{
                        AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                        debugPrint(error?.localizedDescription ?? "Getting user profile error")
                    }
                    
                })
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    func displayCircularProgress(){
        let angle = getAngle(value: Double(resultPercentage), outOf: 100)
        currentProgress.animate(toAngle: angle, duration: 1.0, completion: nil)
        currentProgressLabel.text = "\(resultPercentage)% Current"
        overallProgress.animate(toAngle: angle, duration: 1.0, completion: nil)
        overallProgressLabel.text = "\(resultPercentage)% Overall"
    }
    
    func displayStudyProgress(withDict json:JSON) {
        let subjects = json["value"].arrayValue
        
        for item in subjects {
            let sub = (item["sis_name"].stringValue, item["sis_obtainedmarks"].stringValue, item["sis_totalmarks"].stringValue, "A")
            arrScoreData.append(sub)
        }
        
    }
    
    func configDropDown(){
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        dropDownClasses.anchorView = viewOptions // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.pickerData
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblSelectedOption.text = self.pickerData[index]
            self.onCategoryChange(withCategoryIndex: index)
        }
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        self.onStudentCategoryInfoClick()
    }
    
    func onStudentCategoryInfoClick(){
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else{
            dropDownClasses.hide()
        }
    }
    
    func getAngle(value: Double, outOf: Double) -> Double {
        return 360 * (value / outOf)
    }
    
    func onCategoryChange(withCategoryIndex row: Int){
    }
    
    func updateGraph(){
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.
        
        chtChart.xAxis.stringEntries = exams
        
        //here is the for loop
        for i in 0..<numbers.count {
            
            let value = ChartDataEntry(x: Double(i), y: Double(numbers[i])) // here we set the X and Y status in a data chart entry
            lineChartEntry.append(value) // here we add it to the data set
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "x-axis: Exams/Test and y-axis: Marks") //Here we convert lineChartEntry to a LineChartDataSet
        
        line1.colors = [NSUIColor.blue] //Sets the colour to blue
        
        
        let data = LineChartData() //This is the object that will be added to the chart
        
        data.addDataSet(line1) //Adds the line to the dataSet
        
        
        chtChart.data = data //finally - it adds the chart data to the chart and causes an update
        
        chtChart.chartDescription?.text = "Performance Chart" // Here we set the description for the graph
        
        chtChart.leftAxis.axisMinimum = 0
        chtChart.leftAxis.axisMaximum = 100
        chtChart.rightAxis.axisMaximum = 0
        chtChart.animate(xAxisDuration: 1)
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

//MARK:- UITableview delegate
extension PerformanceScoreViewController:  UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrScoreData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentHeaderReusableView") as! AssignmentHeaderReusableView
        viewHeader.lblDescription.textAlignment = .left
        viewHeader.lblDescription.text = "Subject"
        viewHeader.lblIssueDate.text = "Obtained"
        viewHeader.lblSubmitDate.text = "Total"
        viewHeader.lblAction.text = "Grade"
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AssignmentHeaderReusableView") as! AssignmentHeaderReusableView
        viewFooter.lblDescription.textAlignment = .left
        viewFooter.lblDescription.text = "Total Marks"
        viewFooter.lblIssueDate.text = "327"
        viewFooter.lblSubmitDate.text = "400"
        viewFooter.lblAction.text = "82%"
        viewFooter.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewFooter
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell") as! ScoreTableViewCell
        cell.lblSubject.text = arrScoreData[indexPath.row].0
        cell.lblMarks.text = arrScoreData[indexPath.row].1
        cell.lblTotal.text = arrScoreData[indexPath.row].2
        cell.lblGrade.text = arrScoreData[indexPath.row].3
        return cell
        
    }
}

//MARK:- String extension
extension String {
    public func getAcronyms(separator: String = "") -> String {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first!) }).joined(separator: separator);
        return acronyms
    }
}
