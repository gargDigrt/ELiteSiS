//
//  FeeInfoTableViewCell.swift
//  EliteSISSwift
//
//  Created by Daffolap-51 on 22/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var tableData : FeeViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerView()
    }
    
    
    func registerView(){
        tableView.register(UINib(nibName:"FeeInfoHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeeInfoHeaderView")
        tableView.register(UINib(nibName:"FeeTotalTableViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeeTotalTableViewCell")
        tableView.register(UINib(nibName: "FeeItemsTableViewCell", bundle:nil), forCellReuseIdentifier: "FeeItemsTableViewCell")
    }
    
    func bindData(data: FeeViewModel){
        self.cellTitleLabel.text = data.headerTitle
        self.tableData = data
        self.tableView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FeeInfoTableViewCell: UITableViewDataSource,UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableData?.cellType != .PaymentHistory{
            return 0
        }
            return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData?.items.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeeInfoHeaderView") as! FeeInfoHeaderView
        viewHeader.bindHeaderText(h1: tableData?.cellH1Text, h2: tableData?.cellH2Text, h3: tableData?.cellH3Text)
        return viewHeader
       
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let viewFooter = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeeTotalTableViewCell") as! FeeTotalTableViewCell
            return viewFooter
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "FeeItemsTableViewCell") as! FeeItemsTableViewCell
        itemCell.bindHeaderText(data: self.tableData!.items[indexPath.row],cellType:self.tableData!.cellType )
        return itemCell
        
    }
    
}
