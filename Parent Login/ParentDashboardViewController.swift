//
//  ParentDashboardViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 10/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ParentDashboardViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    private enum Cells: Int{
        case FEE_REMINDER
        case PARENT_NOTICE
        case EVENT_NOTICE
        case CHILD_NOTICE
        case UPCOMING_NOTICE
    }
    
    private enum CELL_IDENTIFIERS: String{
        case FEE_REMINDER  = "FeeReminderTableViewCell"
        case PARENT_NOTICE = "ParentNoticeTableViewCell"
        case PINBOARD  = "EventNoticeTableViewCell"
        case NOTIFICATION = "ChildNoticeTableViewCell"
        case UPCOMING_EVENTS = "UpcomingEventsTableViewCell"
    }

    @IBOutlet weak var tblViewDashboard: UITableView!
    var dataSourceChild = ChildViewDataModel().getDummyData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true;
        self.configTableView()
    }
    
    func configTableView(){
        tblViewDashboard.register(UINib(nibName:"ParentDashboardHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ParentDashboardHeaderView")
        
        tblViewDashboard.register(UINib(nibName: CELL_IDENTIFIERS.FEE_REMINDER.rawValue, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIERS.FEE_REMINDER.rawValue)
        tblViewDashboard.register(UINib(nibName: CELL_IDENTIFIERS.PARENT_NOTICE.rawValue, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIERS.PARENT_NOTICE.rawValue)
        tblViewDashboard.register(UINib(nibName: CELL_IDENTIFIERS.PINBOARD.rawValue, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIERS.PINBOARD.rawValue)
        tblViewDashboard.register(UINib(nibName: CELL_IDENTIFIERS.NOTIFICATION.rawValue, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIERS.NOTIFICATION.rawValue)
        tblViewDashboard.register(UINib(nibName: CELL_IDENTIFIERS.UPCOMING_EVENTS.rawValue, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIERS.UPCOMING_EVENTS.rawValue)
        
        tblViewDashboard.dataSource = self
        tblViewDashboard.delegate = self
        tblViewDashboard.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ParentDashboardHeaderView") as! ParentDashboardHeaderView
        viewHeader.bind(data: self.dataSourceChild)
        viewHeader.delegate = self
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case Cells.FEE_REMINDER.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIERS.FEE_REMINDER.rawValue, for: indexPath) as! FeeReminderTableViewCell
            cell.selectionStyle = .none
            return cell
        case Cells.PARENT_NOTICE.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIERS.PARENT_NOTICE.rawValue, for: indexPath) as! ParentNoticeTableViewCell
            cell.selectionStyle = .none
            return cell
        case Cells.EVENT_NOTICE.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIERS.PINBOARD.rawValue, for: indexPath) as! EventNoticeTableViewCell
            cell.selectionStyle = .none
            return cell
        case Cells.CHILD_NOTICE.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIERS.NOTIFICATION.rawValue, for: indexPath) as! ChildNoticeTableViewCell
            cell.selectionStyle = .none
            return cell
        case Cells.UPCOMING_NOTICE.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIERS.UPCOMING_EVENTS.rawValue, for: indexPath) as! UpcomingEventsTableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            cell.config(data: EventViewDataModel().getDummyData())
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case Cells.FEE_REMINDER.rawValue:
            self.showFeeInformationViewControler()
        case Cells.EVENT_NOTICE.rawValue:
            self.showEventNoticeViewController()
        case Cells.CHILD_NOTICE.rawValue:
            self.showNotificationViewController()
        default:
            break
        }
    }
    
    func showFeeInformationViewControler(){
        let feeInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "FeeInformationViewController") as! FeeInformationViewController
        self.navigationController?.pushViewController(feeInfoVC, animated: true)
    }
    
    func showEventNoticeViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PinboardViewController") as! PinboardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showNotificationViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
    
}


// MARK: - ParenParentDashboardHeaderView Protocol
extension ParentDashboardViewController: ParenParentDashboardHeaderViewProtocol{
    func childSelectedWithInfo(info: ChildViewDataModel){
        //Move to child section with data
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
        vc.studentName = info.name
        vc.allowBack = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UpcomingEvents Protocol
extension ParentDashboardViewController: UpcomingEventsProtocol{
    func eventSelectedWithData(event: EventViewDataModel) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventGalleryListViewController") as! EventGalleryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
