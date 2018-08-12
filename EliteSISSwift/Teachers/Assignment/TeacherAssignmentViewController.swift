//
//  TeacherAssignmentViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 05/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

enum TEACHER_ASSIGNMENT_TYPE{
    case ALL
    case DUE
    case SUBMITTED
}

class TeacherAssignmentViewController: UIViewController {
    
    @IBOutlet weak var tblViewAssignment: UITableView!
    @IBOutlet weak var txtFieldSearch: UITextField!
    var assignmentType: TEACHER_ASSIGNMENT_TYPE!
    @IBOutlet weak var lblClassType: UIButton!
    var classType: String = ""
    var dataSource = TeacherAssginementResponseModel().getDummyData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.customizeView()
        self.configTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func customizeView(){
        self.lblClassType.setTitle(classType, for: .normal)
    }
}

// MARK: - Table View Setup
extension TeacherAssignmentViewController: UITableViewDelegate, UITableViewDataSource{
    func configTableView(){
        self.tblViewAssignment.delegate = self
        self.tblViewAssignment.dataSource = self
        self.tblViewAssignment.separatorStyle = .none
        
        self.tblViewAssignment.register(UINib(nibName: "TeacherAssignmentDetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "TeacherAssignmentDetailTableViewCell")
        self.tblViewAssignment.register(UINib(nibName: "TeacherAssignmentHeaderFooterView", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "TeacherAssignmentHeaderFooterView")
        
        self.tblViewAssignment.reloadData()
    }
    
    //MARK: Table view delegate and datasoruce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TeacherAssignmentHeaderFooterView") as! TeacherAssignmentHeaderFooterView
        headerView.config(assignmentType: assignmentType)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherAssignmentDetailTableViewCell") as! TeacherAssignmentDetailTableViewCell
        cell.selectionStyle = .none
        cell.config(assignmentType: assignmentType, dataSource: self.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
