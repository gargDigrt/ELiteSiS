//
//  NotificationViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

class NotificationViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    //IBOutlets
    
    @IBOutlet weak var segmentedControlNotification: UISegmentedControl!
    @IBOutlet weak var collectionViewNotifications: UICollectionView!
    
    // VARiables
    var todayDatasource = TodayDatasource()
    var allDatasource = AllDatasource()
    var missedDataSource = MissedDatasource()
    // Static
    let contactID = "65e99ee3-7669-e811-8157-c4346bdc1f11"
    
    //MARK:- View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewNotifications.register(UINib(nibName:"NotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotificationCollectionViewCell")
        
        segmentedControlNotification.addTarget(self, action: #selector(changeCollectionViewCell(segmentedControl:)), for: .valueChanged)
        
        getAllNotificationForUser()
        
    }
    //MARK:- Button actions
    
    @objc func changeCollectionViewCell(segmentedControl:UISegmentedControl) {
        collectionViewNotifications.scrollToItem(at: IndexPath(item: segmentedControl.selectedSegmentIndex, section: 0), at: .centeredHorizontally, animated: true)
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
    
    // MARK:- Web service call
    
    func getAllNotificationForUser() {
        ProgressLoader.shared.showLoader(withText: "Loading Data")
        WebServices.shared.getNotificationFor(contactID: contactID, completion: { (response, error) in
            if error == nil , let responseDict = response {
                print(responseDict)
                let notifications = responseDict["value"].arrayValue
                self.categoriesNotifications(from: notifications)
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "fetching dashboard error")
            }
            ProgressLoader.shared.hideLoader()
        })
    }
    
    
    func categoriesNotifications(from json: [JSON]) {
        
        var todayAry:[JSON] = []
        var missedAry:[JSON] = []
        var allAry:[JSON] = []
        for item in json {
            var crationDate = item["createdon"].stringValue
            crationDate = Date.getFormattedDate(string: crationDate, formatter: "dd-mm-yy")
            let currentDate = Date.getCurrentDateWithFormat(format: "dd-mm-yy")
            
            if crationDate == currentDate {
                todayAry.append(item)
            }else{
                missedAry.append(item)
            }
            allAry.append(item)
        }
        self.allDatasource.configureData(from: allAry)
        self.missedDataSource.configureData(from: missedAry)
        self.todayDatasource.configureData(from: todayAry)
    }
}

//MARK:-  ScrollView delegate

extension NotificationViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionViewNotifications.contentOffset
        visibleRect.size = collectionViewNotifications.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionViewNotifications.indexPathForItem(at: visiblePoint)!
        
        segmentedControlNotification.selectedSegmentIndex = visibleIndexPath.row
        
    }
}


//MARK:-  Collectionview delegate and datsource

extension NotificationViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewNotifications.frame.width , height: collectionViewNotifications.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCollectionViewCell", for: indexPath) as! NotificationCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.tblViewDetails.dataSource = todayDatasource
            return cell
        
        case 1:
            cell.tblViewDetails.dataSource = allDatasource
            return cell
          
        default:
            cell.tblViewDetails.dataSource = missedDataSource
            return cell
           
        }
        
    }
    
}
