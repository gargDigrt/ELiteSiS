//
//  AddAssignmentViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 17/05/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AddAssignmentViewController: UIViewController {
    
    @IBOutlet weak var txtFieldSubject: UITextField!
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtFieldIssueDate: UITextField!
    @IBOutlet weak var txtFieldLastDate: UITextField!
    @IBOutlet weak var txtViewDesciption: UITextView!
    @IBOutlet weak var lblAssignmentName: UILabel!
    var isSelectingIssueDate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initView()
    }
    
    func initView(){
        self.setTextViewPlaceholder()
    }
    
    func setTextViewPlaceholder(){
        self.txtViewDesciption.textColor = UIColor.lightGray
        self.txtViewDesciption.text = "Enter Description"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func validateInput()->(isValid: Bool, errorMsg: String?){
       
        guard self.txtFieldSubject.text != nil && !self.txtFieldSubject.text!.isEmpty else{return(false, "Please enter subject")}
        
        guard self.txtFieldTitle.text != nil && !self.txtFieldTitle.text!.isEmpty else{return(false, "Please enter Title")}
        
        guard self.txtFieldIssueDate.text != nil && !self.txtFieldIssueDate.text!.isEmpty else{return(false, "Please select issue date")}
        
        guard self.txtFieldLastDate.text != nil && !self.txtFieldLastDate.text!.isEmpty else{return(false, "Please select last date")}
        
        guard self.txtViewDesciption.text != nil && !self.txtViewDesciption.text!.isEmpty && !(self.txtViewDesciption.text! == "Enter Description") else{return(false, "Please enter description")}

        
        return (true, nil)
    }
    
    func showAlertWithTitle(title: String?, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        let validation = validateInput()
        
        if validation.isValid{
            self.showAlertWithTitle(title: nil, message: "Assignment Uploaded Successfully!")
        }
        else{
            self.showAlertWithTitle(title: nil, message: validation.errorMsg!)
        }
    }
    
    @IBAction func onIssueDateClick(_ sender: Any) {
        self.isSelectingIssueDate = true
        self.showDatePicker()
    }
    
    @IBAction func onLastDateClick(_ sender: Any) {
        self.isSelectingIssueDate = false
        self.showDatePicker()
    }
    
    @IBAction func onUploadClick(_ sender: Any) {
       // let documentController = UIDocumentPickerViewController(documentTypes: ["public.text"], in: .import)
        let documentController = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .import)

//        let documentController = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)

        documentController.delegate = self
        documentController.modalPresentationStyle = .formSheet
        self.present(documentController, animated: true, completion: nil)
    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onMenuClick(_ sender: Any) {
        self.toggleSideMenuView()
    }
}

extension AddAssignmentViewController: DatePickerProtocol{
    
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
        if isSelectingIssueDate{
            self.txtFieldIssueDate.text = date
        }
        else{
            self.txtFieldLastDate.text = date
        }
    }
}

extension AddAssignmentViewController: UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]){
        let name = urls.first?.lastPathComponent
        self.lblAssignmentName.text = name
    }
}

extension AddAssignmentViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.setTextViewPlaceholder()
        }
    }
}

