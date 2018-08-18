//
//  TeachersTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 25/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol TeachersViewActionMethods {
    func showTeachersProfile()
    func showTeachersChat()
    func showTeachersSendMsg()
}

class TeachersTableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewTeacher: UIImageView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var btnTeacherProfile: UIButton!
    @IBOutlet weak var btnTeacherChat: UIButton!
    @IBOutlet weak var btnTeacherSendMsg: UIButton!
    var delegateTeachersMethods:TeachersViewActionMethods?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayDataFrom(teacher: JSON) {
        let name = teacher["FacultyName"].stringValue
        teacherNameLabel.text = name
    }

    @IBAction func btnTeacherProfileClicked(_ sender: UIButton) {
        delegateTeachersMethods?.showTeachersProfile()
    }
    
    @IBAction func btnTeacherChatClicked(_ sender: UIButton) {
        delegateTeachersMethods?.showTeachersChat()
    }
    
    @IBAction func btnTeacherSendMsgClicked(_ sender: UIButton) {
        delegateTeachersMethods?.showTeachersSendMsg()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

