//
//  FeeInformationViewController.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

enum FeeCellType{
    case PaymentHistory
    case Installments
}

enum FeeStatusType : String{
    case Clear = "Clear"
    case Due = "Due"
}


class FeeInformationViewController: UIViewController {

    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var installemtView: UIView!
    var dataSource : [FeeViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView(){
        self.addShadowForView(myView: self.installemtView)
        self.registerViews()
        self.setCellView()
        self.tblView.reloadData()
    }
    
    func registerViews(){
        tblView.register(UINib(nibName:"FeeInfoTableViewCell", bundle:nil), forCellReuseIdentifier: "FeeInfoTableViewCell")
    }
    
    func setCellView(){
        let paymentModel : FeeItemModel = FeeItemModel(count: "1", cellItem1: "XYZ", cellItem2: "10th Jan 2018", cellItem3: "₹ 5275")
        let paymentHistoryDetails = FeeViewModel(headerTitle: "Fee Payment History", cellH1Text: "Receipt No", cellH2Text: "Date", cellH3Text: "Amount", cellType: .PaymentHistory, items: [paymentModel])
        
        
        
        let installemntModel1 : FeeItemModel = FeeItemModel(count: "1", cellItem1: "10th Jan 2018", cellItem2: "₹ 5275", cellItem3: FeeStatusType.Clear.rawValue)
        
         let installemntModel2 : FeeItemModel = FeeItemModel(count: "2", cellItem1: "10th Mar 2018", cellItem2: "₹ 5000", cellItem3: FeeStatusType.Due.rawValue)
        
        let InstallentsDetails = FeeViewModel(headerTitle: "Fee Installments", cellH1Text: "Installment Dates", cellH2Text: "Amount", cellH3Text: "Status", cellType: .Installments, items: [installemntModel1,installemntModel2])
        
        
        dataSource.append(paymentHistoryDetails)
        dataSource.append(InstallentsDetails)
    }

    private func addShadowForView(myView: UIView){
        myView.layer.cornerRadius = 10
        myView.clipsToBounds = true
        myView.layer.shadowPath = UIBezierPath(roundedRect:
            myView.bounds, cornerRadius: myView.layer.cornerRadius).cgPath
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = 0.3
        myView.layer.shadowOffset = .zero
        myView.layer.shadowRadius = 5
        myView.layer.masksToBounds = false
    }
    @IBAction func showMenu(_ sender: Any) {
        toggleSideMenuView()
    }

    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FeeInformationViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeeInfoTableViewCell") as! FeeInfoTableViewCell
        cell.bindData(data: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
             return 200
        }
        return 194
    }

    
}
