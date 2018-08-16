//
//  DatePickerViewController.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 05/05/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol DatePickerProtocol: class {
    func dateSelected(date: Date)
    func datePickerCancel()
}

class DatePickerViewController: UIViewController {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewBg.backgroundColor = UIColor.clear
        
        self.datePicker.datePickerMode = .date
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewBg.backgroundColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDoneClick(_ sender: Any) {
        self.viewBg.backgroundColor = UIColor.clear
        self.delegate?.dateSelected(date: self.datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        self.viewBg.backgroundColor = UIColor.clear
        self.delegate?.datePickerCancel()
        self.dismiss(animated: true, completion: nil)
    }

}
