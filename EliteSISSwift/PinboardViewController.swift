//
//  PinboardViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 16/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class PinboardViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var segmentedControlNotification: UISegmentedControl!
    @IBOutlet weak var collectionViewNotifications: UICollectionView!
    var todayDatasource = TodayPinboardDataSource()
    var allDatasource = UpcomingPinboardDataSource()
    var missedDataSource = PastPinboardDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //http://43.224.136.81:5015/SIS_Student/GetPinboardList
        collectionViewNotifications.dataSource = self
        collectionViewNotifications.delegate = self
        collectionViewNotifications.register(UINib(nibName:"NotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NotificationCollectionViewCell")
        
        segmentedControlNotification.addTarget(self, action: #selector(changeCollectionViewCell(segmentedControl:)), for: .valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewNotifications.frame.width , height: collectionViewNotifications.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionViewNotifications.contentOffset
        visibleRect.size = collectionViewNotifications.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionViewNotifications.indexPathForItem(at: visiblePoint)!
        
        segmentedControlNotification.selectedSegmentIndex = visibleIndexPath.row
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotificationCollectionViewCell", for: indexPath) as! NotificationCollectionViewCell
        
        switch indexPath.row {
        case 0:
            todayDatasource.configureData()
            cell.tblViewDetails.dataSource = todayDatasource
            return cell
            
        case 1:
            allDatasource.configureData()
            cell.tblViewDetails.dataSource = allDatasource
            return cell
            
        default:
            missedDataSource.configureData()
            cell.tblViewDetails.dataSource = missedDataSource
            return cell
        }
        
        
    }
    
    @objc func changeCollectionViewCell(segmentedControl:UISegmentedControl) {
        collectionViewNotifications.scrollToItem(at: IndexPath(item: segmentedControl.selectedSegmentIndex, section: 0), at: .centeredHorizontally, animated: true)
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
        print(UserDefaults.standard.string(forKey: "selectedLogin")!)
        //UserDefaults.standard.string(forKey: "selectedLogin")
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
        //parentdashboard
        hideSideMenuView()
    }
}

