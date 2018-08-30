//
//  EventGalleryViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import FSCalendar

struct Album {
    let albumID: String
    let name: String?
    let thumbnail: UIImage?
    
    init(albumID: String, name: String?, thumbnail: UIImage = #imageLiteral(resourceName: "ic_gallery_black")) {
        self.albumID = albumID
        self.name = name
        self.thumbnail = thumbnail
    }
}


class EventGalleryViewController: UIViewController{
    
    //IBOutlet----------
    @IBOutlet weak var segmentEventGallery: UISegmentedControl!
    @IBOutlet weak var collectionViewGallery: UICollectionView!
    @IBOutlet weak var viewEventG: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet var tableView: UITableView!
    
    //Variables
    var albums: [Album] = []
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
    
    //Constants
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    
    // Data model: These strings will be the data for the table view cells
    let eventsToShow: [String] = ["PTM", "Awards / Seminar", "Student Wellness Fair", "Exams"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    //MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewGallery.isHidden = true
        
        getGalleryAlbums()
        configureCollectionView()
        configureCalander()
        
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        
        configureTableView()
        
    }
    
    //MARK:- Custom methods
    
    fileprivate func configureCollectionView() {
        // Do any additional setup after loading the view.
        
        collectionViewGallery.register(UINib(nibName:"GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        collectionViewGallery.delegate = self
        collectionViewGallery.dataSource = self
    }
    
    fileprivate func configureCalander() {
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
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        calendar.select(self.dateFormatter1.date(from: formatter.string(from: Date())))
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
    }
    
    fileprivate func configureTableView() {
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    // Web service call to get gallery albums
    func getGalleryAlbums() {
        ProgressLoader.shared.showLoader(withText: "Loading Gallery")
        
        WebServices.shared.getPhotoAlbums(completion: {(response, error ) in
            
            if error == nil , let responseDict = response {
                let albums = responseDict["value"].arrayValue
                
                for item in albums {
                    guard let id = item["new_albumsid"].string  else { return }
                    let name = item["new_name"].string
                    if let imgString = item["entityimage"].string{
                        let image = UIImage.decodeBase64(toImage: imgString)
                        let album = Album(albumID: id, name: name, thumbnail: image)
                        self.albums.append(album)
                    }else{
                        let album = Album(albumID: id, name: name)
                        self.albums.append(album)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionViewGallery.reloadData()
                    ProgressLoader.shared.hideLoader()
                }
            }else{
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting gallery album error")
            }
        })
    }
    
    //MARK:- Button action
    
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
    
    //MARK:- Selector methods
    
    @objc func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    
}

//MARK:- UITableView Delegate & Datasource
extension EventGalleryViewController: UITableViewDelegate, UITableViewDataSource  {
    
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
}

//MARK:- UICollectionView Delegate & Datasource
extension EventGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor((UIScreen.main.bounds.width - 70)/3)
        let height = width + 50
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        if let image = albums[indexPath.row].thumbnail {
            cell.imgView.image = image
        }else{
            cell.imgView.image = nil
        }
        if let nameText = albums[indexPath.row].name {
            cell.lblText.text = nameText
        }else{
            cell.lblText.text = "No name"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let galeryVC = storyBoard.instantiateViewController(withIdentifier: "GalleryPhotosViewController") as! GalleryPhotosViewController
        let albumID = albums[indexPath.row].albumID
        galeryVC.albumID = albumID
        galeryVC.index = indexPath.item
        self.present(galeryVC, animated:true, completion:nil)
    }
    
}

//MARK:- FSCalender Delegate & Datasource
extension EventGalleryViewController:  FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance {
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

//MARK:- UIImage extension

extension UIImage {
    
    /*
     @brief decode image base64
     */
    static func decodeBase64(toImage strEncodeData: String!) -> UIImage {
        
        if let decData = Data(base64Encoded: strEncodeData, options: .ignoreUnknownCharacters), strEncodeData.count > 0 {
            return UIImage(data: decData)!
        }
        return UIImage()
    }
}
