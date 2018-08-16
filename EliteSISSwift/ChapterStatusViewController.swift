//
//  ChapterStatusViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChapterStatusViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblViewChapterStatus: UITableView!
    var arrChapter = [String]()
    var arrStatus = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewChapterStatus.delegate = self
        tblViewChapterStatus.dataSource = self
        tblViewChapterStatus.separatorStyle = .none
        tblViewChapterStatus.sectionHeaderHeight = 45
        tblViewChapterStatus.rowHeight = 45
        tblViewChapterStatus.register(UINib(nibName:"ChapterStatusHeaderReusableView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ChapterStatusHeaderReusableView")
        tblViewChapterStatus.register(UINib(nibName:"ChapterStatusTableViewCell", bundle:nil), forCellReuseIdentifier: "ChapterStatusTableViewCell")
        arrChapter = ["Chapter 1","Chapter 2","Chapter 3","Chapter 4","Chapter 5","Chapter 6","Chapter 7","Chapter 8","Chapter 9","Chapter 10"]
        arrStatus = ["Completed", "Completed", "Completed", "In Progress", "Completed", "Completed","Not Started", "Completed", "Completed", "In Progress"]
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChapter.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ChapterStatusHeaderReusableView") as! ChapterStatusHeaderReusableView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChapterStatusTableViewCell") as! ChapterStatusTableViewCell
        cell.lblChapter.text = arrChapter[indexPath.row]
        cell.lblStatus.text = arrStatus[indexPath.row]
        cell.selectionStyle = .none
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
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "StudyProgressViewController")
        sideMenuController()?.setContentViewController(destViewController)
       //destsideMenuAnimationType = 0
       // sideMenuController()
        
        hideSideMenuView()
    }
}
