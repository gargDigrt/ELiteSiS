//
//  AttendanceViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//


//https://github.com/WenchaoD/FSCalendar/blob/master/MOREUSAGE.md
import UIKit

class AttendanceViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance,ENSideMenuDelegate {
   // fileprivate weak var calendar: FSCalendar!
    
    @IBOutlet weak var lblPresencePercentMonth: UILabel!
    @IBOutlet weak var lblAbsentNumber: UILabel!
    @IBOutlet weak var lblPresentnumber: UILabel!
    @IBOutlet weak var presencePercentSession: UILabel!
    
    @IBOutlet
    weak var calendar: FSCalendar!
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
//    let fillSelectionColors = ["2018/02/08": UIColor.green, "2018/02/06": UIColor.purple, "2018/02/17": UIColor.gray, "2018/02/21": UIColor.cyan, "2018/02/08": UIColor.green, "2018/02/06": UIColor.purple, "2018/02/17": UIColor.gray, "2018/02/21": UIColor.cyan, "2015/12/08": UIColor.green, "2015/12/06": UIColor.purple, "2015/12/17": UIColor.gray, "2015/12/21": UIColor.cyan]
    
    
    let fillDefaultColors = ["2018/04/04": UIColor.green, "2018/04/02": UIColor.green, "2018/04/03": UIColor.green, "2018/04/13": UIColor.green, "2018/04/05": UIColor.green, "2018/04/06": UIColor.green, "2018/04/07": UIColor.red, "2018/04/11": UIColor.red, "2018/04/09": UIColor.red, "2018/04/10": UIColor.red, "2018/04/12": UIColor.green, "2018/04/18": UIColor.green, "2018/04/14": UIColor.green, "2018/04/16": UIColor.red, "2018/04/17": UIColor.red, "2018/04/19": UIColor.green, "2018/04/20": UIColor.green, "2018/04/25": UIColor.green, "2018/04/23": UIColor.green, "2018/04/24": UIColor.green, "2018/04/26": UIColor.green, "2018/04/27": UIColor.green,"2018/04/21": UIColor.green]

//    let borderDefaultColors = ["2018/02/08": UIColor.brown, "2018/02/17": UIColor.magenta, "2018/02/21": UIColor.cyan, "2018/02/25": UIColor.black, "2018/02/08": UIColor.brown, "2018/02/17": UIColor.magenta, "2018/02/21": UIColor.cyan, "2018/02/25": UIColor.black, "2015/12/08": UIColor.brown, "2015/12/17": UIColor.magenta, "2015/12/21": UIColor.purple, "2015/12/25": UIColor.black]
//
//    let borderSelectionColors = ["2018/02/08": UIColor.red, "2018/02/17": UIColor.purple, "2018/02/21": UIColor.cyan, "2018/02/25": UIColor.magenta, "2018/02/08": UIColor.red, "2018/02/17": UIColor.purple, "2018/02/21": UIColor.cyan, "2018/02/25": UIColor.purple, "2015/12/08": UIColor.red, "2015/12/17": UIColor.purple, "2015/12/21": UIColor.cyan, "2015/12/25": UIColor.magenta]
    
   // var datesWithEvent = ["2015-10-03", "2015-10-06", "2015-10-12", "2015-10-25"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let view = UIView(frame: UIScreen.main.bounds)
//        view.backgroundColor = UIColor.groupTableViewBackground
//        self.view = view
//
//        let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 450 : 300
//        let calendar = FSCalendar(frame: CGRect(x:0, y:64, width:self.view.bounds.size.width, height:height))
        calendar.dataSource = self
        calendar.delegate = self
        //calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.backgroundColor = UIColor.white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
//        self.view.addSubview(calendar)
//        self.calendar = calendar
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        calendar.select(self.dateFormatter1.date(from: formatter.string(from: date)))
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        // Do any additional setup after loading the view.
        
        lblPresentnumber.text = "Present: 0"
        lblAbsentNumber.text = "Absent: 0"
        lblPresencePercentMonth.text = "- 0% presence in this month."
        presencePercentSession.text = "- 0% presence in this session."
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

    @objc
    func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let dateString = self.dateFormatter2.string(from: date)
//        if self.datesWithEvent.contains(dateString) {
//            return 1
//        }
//
//        return 0
//    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
//        let dateString = self.dateFormatter2.string(from: date)
//        if self.datesWithEvent.contains(dateString) {
//            return UIColor.purple
//        }
//        return nil
//    }
//
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
     //   let key = self.dateFormatter2.string(from: date)
//        if self.datesWithMultipleEvents.contains(key) {
//            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
//        }
        return nil
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.fillSelectionColors[key] {
//            return color
//        }
//        return appearance.selectionColor
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return color
        }
        return nil
    }
    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar){
//    print(calendar.currentPage)
//}
    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
        // Do something
        
        print(calendar.currentPage)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let myString = formatter.string(from: calendar.currentPage as Date)
        print(myString)
        
        if (myString == "2018-04-01"){
            lblPresentnumber.text = "Present: 17"
            lblAbsentNumber.text = "Absent: 6"
            lblPresencePercentMonth.text = "- 75% presence in this month."
            presencePercentSession.text = "- 75% presence in this session."
        }else{
            
            lblPresentnumber.text = "Present: 0"
            lblAbsentNumber.text = "Absent: 0"
            lblPresencePercentMonth.text = "- 0% presence in this month."
            presencePercentSession.text = "- 0% presence in this session."
        }
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.borderDefaultColors[key] {
//            return color
//        }
//        return appearance.borderDefaultColor
//    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
//        let key = self.dateFormatter1.string(from: date)
//        if let color = self.borderSelectionColors[key] {
//            return color
//        }
//        return appearance.borderSelectionColor
//    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
//        if [8, 17, 21, 25].contains((self.gregorian.component(.day, from: date))) {
//            return 0.0
//        }
//        return 1.0
//    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
    @objc func showStudyProgress() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudyProgressViewController")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        //        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //        sideMenuController()?.setContentViewController(destViewController)
        
        let selectedLogin=UserDefaults.standard.string(forKey: "selectedLogin")
        if (selectedLogin == "S"){
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
            sideMenuController()?.setContentViewController(destViewController)
            
        }
        else if(selectedLogin == "E"){
            
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
            sideMenuController()?.setContentViewController(destViewController)
        }
        hideSideMenuView()
    }
}
