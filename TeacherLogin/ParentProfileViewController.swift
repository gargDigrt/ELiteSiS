//
//  ParentProfileViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown

class ParentProfileViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var pickerheightConstant: NSLayoutConstraint!
    @IBOutlet weak var tblViewInfo: UITableView!
    var generalDatasource = GeneralInfoDatasource()
    var contactDatasource = ContactInfoDatasource()
    var classAppliedDatasource = ClassAppliedDatasource()
    var qualificationDatasource = QualificationDatasource()
    var addressDatasource = AddressDatasource()
    var identityCardDatasource = IdentityCardDatasource()
    var pickerData: [String] = [String]()
    var dropDownClasses: DropDown!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var stackViewProfileChangeOptions: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tblViewInfo.separatorStyle = .none
        tblViewInfo.register(UINib(nibName: "TextfieldTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldTableCell")
        tblViewInfo.register(UINib(nibName: "TextFieldWithCalendarTableViewCell", bundle:nil), forCellReuseIdentifier: "textfieldwithCalendarTableCell")
        tblViewInfo.register(UINib(nibName: "DropDownTableViewCell", bundle:nil), forCellReuseIdentifier: "DropDownTableViewCell")
        tblViewInfo.register(UINib(nibName: "DateSelectionTableViewCell", bundle:nil), forCellReuseIdentifier: "DateSelectionTableViewCell")
        
        pickerData = ["General Info", "Contact Info", "Class Applied", "Qualification Detail", "Address Detail", "Identity Card Details"]
        
        tblViewInfo.dataSource = generalDatasource
        tblViewInfo.delegate = self
        tblViewInfo.reloadData()
        
        generalDatasource.delegate = self
        
        // Do any additional setup after loading the view.
        self.configDropDown()
        self.onInfoCategoryChange(withCategoryIndex: 0)
        
        //Make profile image circular
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.bounds.width/2.0
        self.imgViewProfile.clipsToBounds = true
        
        //Hide profile change options
        stackViewProfileChangeOptions.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func onParentCategoryInfoClick(){
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            // show or hide info category dropdown
            self.onParentCategoryInfoClick()
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

extension ParentProfileViewController: GeneralInfoDelegate, DatePickerProtocol{
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

extension ParentProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
            self.imgViewProfile.image = image as? UIImage
            self.dismiss(animated: true, completion: nil)
            self.stackViewProfileChangeOptions.isHidden = true
        }
    
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.dismiss(animated: true, completion: nil)
            self.stackViewProfileChangeOptions.isHidden = true
        }
}
