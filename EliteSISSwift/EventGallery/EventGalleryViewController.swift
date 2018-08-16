//
//  EventGalleryViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class EventGalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance,UITableViewDelegate, UITableViewDataSource {
    
    
   
    
    @IBOutlet weak var segmentEventGallery: UISegmentedControl!
    
    @IBOutlet weak var collectionViewGallery: UICollectionView!
    @IBOutlet weak var viewEventG: UIView!
    @IBOutlet weak var viewGallery: UIView!
    
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
    
    
    var fillDefaultColors = ["2018/05/14": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/16": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/17": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/18": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0),  "2018/05/21": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/22": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0) ]
    
    
    
    // Data model: These strings will be the data for the table view cells
    let eventsToShow: [String] = ["PTM", "Awards / Seminar", "Student Wellness Fair", "Exams"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  viewGallery.isHidden = true
        // Do any additional setup after loading the view.
        
        collectionViewGallery.register(UINib(nibName:"GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        collectionViewGallery.delegate = self
        collectionViewGallery.dataSource = self
        
       // let view = UIView(frame: UIScreen.main.bounds)
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
        
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsToShow.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.eventsToShow[indexPath.row]
        
//        let image : UIImage = UIImage(named: "circleEvent.png")!
//
//        cell.imageView?.image = image
        cell.imageView?.image = UIImage(named:"circleEvent.png")!.withRenderingMode(.alwaysTemplate)
        //UIImage(named: arrMenuImages[indexPath.row])
        
        if(indexPath.row == 0){
            cell.imageView?.tintColor = UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0)
            }
        else if(indexPath.row == 1){
            cell.imageView?.tintColor = UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 2){
            cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 3){
            cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        cell.backgroundColor = .clear
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if(indexPath.row == 0){
            fillDefaultColors = ["2018/05/14": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/16": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/17": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/18": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0),  "2018/05/21": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/22": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0) ]
            //calendar.dataSource = self
            calendar .reloadData()
                   }
        else if(indexPath.row == 1){
            
            fillDefaultColors = ["2018/05/01": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0),  "2018/05/03": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/13": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/05": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/07": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/09": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
            
        }
        else if(indexPath.row == 2){
            
            fillDefaultColors = [ "2018/05/02": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0),  "2018/05/06": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0), "2018/05/08": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0), "2018/05/10": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
         //   cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 3){
            
            fillDefaultColors = ["2018/05/23": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/24": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/25": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/26": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/28": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
            //cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((UIScreen.main.bounds.width - 70)/3)
        let height = width + 50
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            cell.imgView.image = UIImage(named:"student_group")
            cell.lblText.text = "Group Photo"
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            cell.imgView.image = UIImage(named:"classroom")
            cell.lblText.text = "Classroom"
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
            cell.imgView.image = UIImage(named:"school")
            cell.lblText.text = "School"
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let galeryVC = storyBoard.instantiateViewController(withIdentifier: "GalleryPhotosViewController") as! GalleryPhotosViewController
        galeryVC.index = indexPath.item
        self.present(galeryVC, animated:true, completion:nil)
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
  
    @IBAction func segmentSel(_ sender: Any) {
        let index = (sender as AnyObject).selectedSegmentIndex
        if index == 0 {
            viewGallery.isHidden = true
            viewEventG.isHidden = false
        } else {
            viewGallery.isHidden = false
            viewEventG.isHidden = true
        }
        
    }
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
    
   
}
