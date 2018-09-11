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
    
    //IBOutlet
    @IBOutlet weak var lblStudentName: UILabel!
    
    @IBOutlet weak var imgViewStudent: UIImageView!
    @IBOutlet weak var imgViewStudentHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerheightConstant: NSLayoutConstraint?
    @IBOutlet weak var tblViewInfo: UITableView!
    @IBOutlet weak var stackViewProfileChangeOptions: UIStackView!
    
    //VAriables
    var pickerData: [String] = [String]()
    var stateData: [String] = [String]()
    var stateID: [String] = [String]()
    var profileImage:UIImage?
    var studentDetail:StudentAttendanceViewModel!
    var generalDatasource = StudentGeneralInfoDatasource()
    var contactDatasource = StudentContactDatasource()
    var classAppliedDatasource = StudentClassAppliedDatasource()
    var qualificationDatasource = StudentQualificationDatasource()
    var addressDatasource = StudentAddressDatasource()
    var identityCardDatasource = StudentIdentityCardDatasource()
    var dropDownClasses: DropDown!
    var countryId:String = ""

    //MARK:- View's Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        // "Qualification Detail",
        pickerData = ["General Info", "Contact Info", "Class Details",  "Address Detail", "Identity Card Detail"]

        if studentDetail != nil {
            generalDatasource.studentName = studentDetail.name
        }
        // Do any additional setup after loading the view.
        
        self.configDropDown()
        self.onInfoCategoryChange(withCategoryIndex: 0)
        
        //Add delegate to listen for profile tap event
        generalDatasource.delegate = self
        
        
        configureProfileImageView()
        
        //Hide profile change options
        stackViewProfileChangeOptions.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
       // if studentDetail != nil {
        let studentName = UserDefaults.standard.string(forKey: "sis_name")
        lblStudentName.text = studentName
        
        if let img = profileImage {
        self.imgViewStudent.image = img
        }else{
            self.imgViewStudent.image = nil // Placeholder image
        }
      // }
        addresssAPIExecute()
        IDCardAPICall()
    }
    
    fileprivate func configureTableView() {
        tblViewInfo.separatorStyle = .none
        tblViewInfo.register(UINib(nibName: "TextfieldTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldTableCell")
        tblViewInfo.register(UINib(nibName: "TextFieldWithCalendarTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldwithCalendarTableCell")
        tblViewInfo.register(UINib(nibName: "DropDownTableViewCell", bundle:nil), forCellReuseIdentifier: "DropDownTableViewCell")
        tblViewInfo.register(UINib(nibName: "DateSelectionTableViewCell", bundle:nil), forCellReuseIdentifier: "DateSelectionTableViewCell")
        tblViewInfo.register(UINib(nibName: "NewDropDownTableViewCell", bundle:nil), forCellReuseIdentifier: "NewDropDownTableViewCell")
        
        tblViewInfo.dataSource = generalDatasource
        tblViewInfo.delegate = self
        tblViewInfo.reloadData()
    }
    
    fileprivate func configureProfileImageView() {
        imgViewStudent.layer.borderWidth = 1.0
        imgViewStudent.layer.borderColor = UIColor.lightGray.cgColor
        imgViewStudent.layer.cornerRadius = (imgViewStudentHeightConstraint?.constant)!/2
        imgViewStudent.clipsToBounds = true
        //Make profile image circular
        self.imgViewStudent.layer.cornerRadius = self.imgViewStudent.bounds.width/2.0
        self.imgViewStudent.clipsToBounds = true
        
        if let imgData = UserDefaults.standard.data(forKey: "studentImage") {
            profileImage = UIImage(data: imgData)
        }
        
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
    
    func onStudentCategoryInfoClick() {
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else{
            dropDownClasses.hide()
        }
    }
    
    func onInfoCategoryChange(withCategoryIndex row: Int) {
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
            
        }
//        else if row == 3 {
//            tblViewInfo.dataSource = qualificationDatasource
//            tblViewInfo.reloadData()
//
//        }
        else if row == 3 {
            tblViewInfo.dataSource = addressDatasource
            tblViewInfo.reloadData()
            
        }else if row == 4 {
            tblViewInfo.dataSource = identityCardDatasource
            tblViewInfo.reloadData()
            
        }
    }
    
    func IDCardAPICall()  {
        guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else {
            return
        }
        
        WebServices.shared.getID(forRegistrationID: regID, completion: { (response, error) in
            if error == nil, let responseDict = response {
                debugPrint(responseDict)
                UserDefaults.standard.set(responseDict["value"][0]["sis_licensingauthority"].stringValue, forKey: "sis_licensingauthority")
                UserDefaults.standard.set(responseDict["value"][0]["sis_issuedon"].stringValue, forKey: "sis_issuedon")
                UserDefaults.standard.set(responseDict["value"][0]["sis_identitycard"].stringValue, forKey: "sis_identitycard")
                UserDefaults.standard.set(responseDict["value"][0]["sis_expirydate"].stringValue, forKey: "sis_expirydate")
                UserDefaults.standard.set(responseDict["value"][0]["sis_description"].stringValue, forKey: "sis_description")
                UserDefaults.standard.set(responseDict["value"][0]["sis_identity1"].stringValue, forKey: "sis_identity1")
                UserDefaults.standard.set(responseDict["value"][0]["sis_identityid"].stringValue, forKey: "sis_identityid")
            } else {
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    func addresssAPIExecute()  {
        guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else {
            return
        }
        
        WebServices.shared.getAddress(forRegistrationID: regID, completion: { (response, error) in
            
            if error == nil, let responseDict = response {
               
                let address = "\(responseDict["value"][0]["sis_houseno"]), \(responseDict["value"][0]["sis_streetnumber"])"
                UserDefaults.standard.set(address, forKey: "sis_houseno")
               UserDefaults.standard.set(responseDict["value"][0]["sis_addresssubtype"].stringValue, forKey: "sis_addresssubtype")
                UserDefaults.standard.set(responseDict["value"][0]["sis_city"]["sis_name"].stringValue, forKey: "sis_city")
                 UserDefaults.standard.set(responseDict["value"][0]["sis_state"]["sis_name"].stringValue, forKey: "sis_state")
               UserDefaults.standard.set(responseDict["value"][0]["sis_country"]["sis_name"].stringValue, forKey: "sis_country")
                UserDefaults.standard.set(responseDict["value"][0]["sis_postalcode"].stringValue, forKey: "sis_postalcode")
                self.countryId = responseDict["value"][0]["_sis_country_value"].stringValue
                self.stateAPIExecute()
            } else {
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    
    func stateAPIExecute()  {
        WebServices.shared.getStates(forCountryID: self.countryId, completion: { (response, error) in
            if error == nil, let responseDict = response {
                print(responseDict)
                let myData = responseDict["value"].arrayValue
                for states in myData {
                    let stateValue = states["sis_name"].stringValue
                    let stateID = states["sis_stateid"].stringValue
                    self.stateID.append(stateID)
                    self.stateData.append(stateValue)
                    print(self.stateID)
                }
            } else {
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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

extension StudentProfileViewController: GeneralInfoDelegate, DatePickerProtocol {
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
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            vc.present(imagePicker, animated: true, completion: nil)
        }else{
            AlertManager.shared.showAlertWith(title: "Sorry!", message: "Camera not available.")
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        self.profileImage = image 
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
}


