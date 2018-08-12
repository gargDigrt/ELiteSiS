//
//  TeacherDailyScheduleViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 30/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import WRCalendarView
class TeacherDailyScheduleViewController: UIViewController {
 @IBOutlet weak var weekView: WRWeekView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupCalendarData()
        
        //add today button
        let rightButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(moveToToday))
        navigationItem.rightBarButtonItem = rightButton
        
        //add events
       // weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: "Lunch"))
        //        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: ""))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let someDateTime = formatter.date(from: "2018/03/30 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        let someDateTime1 = formatter.date(from: "2018/03/31 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime1!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime1!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime1!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime1!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime1!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        let someDateTime2 = formatter.date(from: "2018/04/02 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime2!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime2!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime2!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime2!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime2!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        
        
        let someDateTime3 = formatter.date(from: "2018/04/03 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime3!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime3!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime3!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime3!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime3!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        
        
        let someDateTime4 = formatter.date(from: "2018/04/04 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime4!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime4!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime4!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime4!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime4!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        
        let someDateTime5 = formatter.date(from: "2018/04/05 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime5!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime5!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime5!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime5!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime5!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        
        let someDateTime6 = formatter.date(from: "2018/04/06 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime6!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime6!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime6!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime6!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime6!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        
        let someDateTime7 = formatter.date(from: "2018/04/07 08:30")
        weekView.addEvent(event: WREvent.make(date: someDateTime7!, chunk: 1.hours, title: "Class 6th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime7!.add(60.minutes), chunk: 1.hours, title: "Class 8th Maths"))
        weekView.addEvent(event: WREvent.make(date: someDateTime7!.add(120.minutes), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: someDateTime7!.add(180.minutes), chunk: 1.hours, title: "Class 7th Science"))
        weekView.addEvent(event: WREvent.make(date: someDateTime7!.add(240.minutes), chunk: 1.hours, title: "Class 11th Chemistry"))
        
        //        weekView.addEvent(event: WREvent.make(date: Date().add(110.minutes), chunk: 1.hours, title: "#4"))
        
//        weekView.addEvent(event: WREvent.make(date: Date().add(1.days), chunk: 1.hours, title: "Lunch"))
//        weekView.addEvent(event: WREvent.make(date: Date().add(2.days), chunk: 1.hours, title: "Lunch"))
//        weekView.addEvent(event: WREvent.make(date: Date().add(3.days), chunk: 1.hours, title: "Lunch"))
//        weekView.addEvent(event: WREvent.make(date: Date().add(4.days), chunk: 1.hours, title: "Lunch"))
//        weekView.addEvent(event: WREvent.make(date: Date().add(5.days), chunk: 1.hours, title: "Lunch"))
//        weekView.addEvent(event: WREvent.make(date: Date().add(6.days), chunk: 1.hours, title: "Lunch"))
        weekView.calendarType = .day
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
    // MARK: - WRCalendarView
    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self as? WRWeekViewDelegate
    }
    @objc func moveToToday() {
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
}
