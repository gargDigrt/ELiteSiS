//
//  AttendanceViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//


//https://github.com/WenchaoD/FSCalendar/blob/master/MOREUSAGE.md
import UIKit
import FSCalendar

class AttendanceViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance,ENSideMenuDelegate {
    
    //IBOutlet
    @IBOutlet weak var lblPresencePercentMonth: UILabel!
    @IBOutlet weak var lblAbsentNumber: UILabel!
    @IBOutlet weak var lblPresentnumber: UILabel!
    @IBOutlet weak var presencePercentSession: UILabel!
    
    @IBOutlet weak var calendar: FSCalendar!
    
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
    
    var monthlyRecord:[String: (Int,Int)] = [:]
    var attndenceDict:[String:UIColor] = [:]
    
    let fillDefaultColors = ["2018/04/04": UIColor.green, "2018/04/02": UIColor.green, "2018/04/03": UIColor.green, "2018/04/13": UIColor.green, "2018/04/05": UIColor.green, "2018/04/06": UIColor.green, "2018/04/07": UIColor.red, "2018/04/11": UIColor.red, "2018/04/09": UIColor.red, "2018/04/10": UIColor.red, "2018/04/12": UIColor.green, "2018/04/18": UIColor.green, "2018/04/14": UIColor.green, "2018/04/16": UIColor.red, "2018/04/17": UIColor.red, "2018/04/19": UIColor.green, "2018/04/20": UIColor.green, "2018/04/25": UIColor.green, "2018/04/23": UIColor.green, "2018/04/24": UIColor.green, "2018/04/26": UIColor.green, "2018/04/27": UIColor.green,"2018/04/21": UIColor.green]
    
    fileprivate func configureCalender() {
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
        calendar.backgroundColor = .white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAttendeceData()
        configureCalender()
        
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        calendar.select(self.dateFormatter1.date(from: formatter.string(from: date)))
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        

        // Do any additional setup after loading the view.
        
        lblPresentnumber.text = "Present: 0"
        lblAbsentNumber.text = "Absent: 0"
        lblPresencePercentMonth.text = "- 0% presence in this month."
        presencePercentSession.text = "- 0% presence in this session."
    }
    
    func getAttendeceData() {
        guard let studentID = UserDefaults.standard.string(forKey: "sis_studentid") else { return }
        ProgressLoader.shared.showLoader(withText: "Fetching Data")
        WebServices.shared.getAttendenceStatusFor(studentID: studentID, completion: {(response, error) in
            
            if error == nil, let respondeDict = response {
                let attandenseString = respondeDict["value"][0]["new_attendancedata"].stringValue
                self.prepareAttandenceData(text: attandenseString)
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user performance error")
            }
        })
    }

    func prepareAttandenceData(text:String) {
       let result = getMonthAndString(text: text)
        
        for (index, month) in result.months.enumerated() {
            let dateArray = getAllDatesFor(month: Int(month)!)
            let colors = getColorFor(string: result.days[index])
            for (date,color) in zip(dateArray, colors) {
                attndenceDict[date] = color
            }
        }
//        debugPrint(attndenceDict)
        calendar.reloadData()
        prepareMonthlyRecord(record: result)
        ProgressLoader.shared.hideLoader()
    }
    func prepareMonthlyRecord(record: (months:[String],days: [String])) {
        
        for (days, month) in zip(record.days, record.months ){
            let presents = days.countInstances(of: "P")
            let absent = days.countInstances(of: "A")
            monthlyRecord[month] = (presents,absent)
        }
    }

    func getAllDatesFor(month: Int) -> [String] {

        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())
        
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        var arrDates = [String]()
        for day in 1...numDays {
            let dateString = "\(year)/\(String(format:"%02d",month))/\(String(format:"%02d",day))"
            arrDates.append(dateString)
        }
        return arrDates
    }
    
    func getColorFor(string: String) -> [UIColor] {
        
        var colors = [UIColor]()
        for (_, char) in string.enumerated() {
            
            switch (char) {
            case "P":
                colors.append(UIColor.green)
                break
            case "A":
                colors.append(UIColor.red)
                break
            case "W":
                colors.append(UIColor.clear)
                break
            default:
                colors.append(UIColor.clear)
                break
            }
        }
        return colors
    }
    
    @objc func todayItemClicked(sender: AnyObject) {
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
        if let color = self.attndenceDict[key] {
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
        formatter.dateFormat = "MM"
        let month = formatter.string(from: calendar.currentPage as Date)
        print(month)
        if let data  = monthlyRecord[month] {
            lblPresentnumber.text = "Present: \(data.0)"
            lblAbsentNumber.text = "Absent: \(data.1)"
            lblPresencePercentMonth.text = "- 0% presence in this month."
            presencePercentSession.text = "- 0% presence in this session."
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
    
    func getMonthAndString(text: String) -> (months: [String],days: [String]) {
        
        var trimmedText = text.replacingOccurrences(of: "]", with: "")
        trimmedText = trimmedText.replacingOccurrences(of: "[", with: "")
        
        let monthArray = (trimmedText.components(separatedBy: CharacterSet.decimalDigits.inverted)).filter{ $0 != "" }
        let dayAry = (trimmedText.components(separatedBy: CharacterSet.decimalDigits)).filter{ $0 != "" }
        
        return (monthArray,dayAry)
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
