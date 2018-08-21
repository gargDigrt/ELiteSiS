//
//  StudentProfileViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown

class StudentProfileViewController: UIViewController, UITableViewDelegate {
    
    
    @IBOutlet weak var lblStudentName: UILabel!
    
    @IBOutlet weak var imgViewStudent: UIImageView!
    @IBOutlet weak var imgViewStudentHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerheightConstant: NSLayoutConstraint?
    @IBOutlet weak var tblViewInfo: UITableView!
    var pickerData: [String] = [String]()
    var studentDetail:StudentAttendanceViewModel!
    var generalDatasource = StudentGeneralInfoDatasource()
    var contactDatasource = StudentContactDatasource()
    var classAppliedDatasource = StudentClassAppliedDatasource()
    var qualificationDatasource = StudentQualificationDatasource()
    var addressDatasource = StudentAddressDatasource()
    var identityCardDatasource = StudentIdentityCardDatasource()
    var dropDownClasses: DropDown!
    @IBOutlet weak var stackViewProfileChangeOptions: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewInfo.separatorStyle = .none
        tblViewInfo.register(UINib(nibName: "TextfieldTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldTableCell")
        tblViewInfo.register(UINib(nibName: "TextFieldWithCalendarTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldwithCalendarTableCell")
        tblViewInfo.register(UINib(nibName: "DropDownTableViewCell", bundle:nil), forCellReuseIdentifier: "DropDownTableViewCell")
        tblViewInfo.register(UINib(nibName: "DateSelectionTableViewCell", bundle:nil), forCellReuseIdentifier: "DateSelectionTableViewCell")

        
        pickerData = ["General Info", "Contact Info", "Class Applied", "Qualification Detail", "Address Detail", "Identity Card Details"]
        
//      let dictValue =  UserDefaults.standard.value(forKey: "DictValue")
//        print(dictValue)
        
        if studentDetail != nil {
            generalDatasource.studentName = studentDetail.name
        }
        tblViewInfo.dataSource = generalDatasource
        tblViewInfo.delegate = self
        tblViewInfo.reloadData()
        imgViewStudent.layer.borderWidth = 1.0
        imgViewStudent.layer.borderColor = UIColor.lightGray.cgColor
        imgViewStudent.layer.cornerRadius = (imgViewStudentHeightConstraint?.constant)!/2
        imgViewStudent.clipsToBounds = true
        // Do any additional setup after loading the view.
        
        self.configDropDown()
        self.onInfoCategoryChange(withCategoryIndex: 0)
        
        //Add delegate to listen for profile tap event
        generalDatasource.delegate = self
        
        //Make profile image circular
        self.imgViewStudent.layer.cornerRadius = self.imgViewStudent.bounds.width/2.0
        self.imgViewStudent.clipsToBounds = true
        
        //Hide profile change options
        stackViewProfileChangeOptions.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
       // if studentDetail != nil {
        let studentName = UserDefaults.standard.string(forKey: "sis_name")
        lblStudentName.text = studentName
        
        let studentImage = UserDefaults.standard.data(forKey: "studentImage")
        self.imgViewStudent.image = UIImage(data: studentImage!)
      // }
    }
    
    func configDropDown(){
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        let studentInfoCategoryCell = self.tblViewInfo.cellForRow(at: IndexPath(row: 0, section: 0))
        dropDownClasses.anchorView = studentInfoCategoryCell // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.pickerData
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.onInfoCategoryChange(withCategoryIndex: index)
        }
    }
    
    func onStudentCategoryInfoClick(){
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else{
            dropDownClasses.hide()
        }
    }
    
    func onInfoCategoryChange(withCategoryIndex row: Int){
        if row == 0 {
            if studentDetail != nil {
                generalDatasource.studentName = studentDetail.name
            }
            tblViewInfo.dataSource = generalDatasource
            tblViewInfo.reloadData()
            
        } else if row == 1 {
            tblViewInfo.dataSource = contactDatasource
            tblViewInfo.reloadData()
            
        }else if row == 2 {
            tblViewInfo.dataSource = classAppliedDatasource
            tblViewInfo.reloadData()
            
        }else if row == 3 {
            tblViewInfo.dataSource = qualificationDatasource
            tblViewInfo.reloadData()
            
        }else if row == 4 {
            tblViewInfo.dataSource = addressDatasource
            tblViewInfo.reloadData()
            
        }else if row == 5 {
            tblViewInfo.dataSource = identityCardDatasource
            tblViewInfo.reloadData()
            
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            tblViewBottomConstraint.constant = kbHeight - 180
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 10
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            // show or hide info category dropdown
            self.onStudentCategoryInfoClick()
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
    
    @IBAction func btnProfilePicClick(_ sender: Any) {
        self.stackViewProfileChangeOptions.isHidden = !self.stackViewProfileChangeOptions.isHidden
    }
    
    @IBAction func btnOpenCameraClick(_ sender: Any) {
        self.openCamera(vc: self)
    }
    
    @IBAction func btnOpenGalleryClick(_ sender: Any) {
        self.openGallery(vc: self)
    }
}

extension StudentProfileViewController: GeneralInfoDelegate, DatePickerProtocol{
    func showDatePicker(){
        let vcPicker = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        vcPicker.modalPresentationStyle = .overCurrentContext
        vcPicker.delegate = self
        self.present(vcPicker, animated: true, completion: nil)
    }
    
    func calendarClicked() {
        self.showDatePicker()
    }
    
    func dateSelected(date: Date) {
        self.setSelectedDate(date: date.format(with: "dd-MMM-yyyy"))
    }
    
    func datePickerCancel() {
        
    }
    
    func setSelectedDate(date: String){
        let cell = tblViewInfo.cellForRow(at: IndexPath(row: 2, section: 0)) as! DateSelectionTableViewCell
        cell.lblDate.text = date
    }
}

extension StudentProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openGallery(vc: UIViewController){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(vc: UIViewController){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerEditedImage]
        self.imgViewStudent.image = image as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
}


