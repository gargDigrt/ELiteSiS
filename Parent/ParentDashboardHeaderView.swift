//
//  ParentDashboardHeaderView.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 14/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol ParenParentDashboardHeaderViewProtocol: class {
    func childSelectedWithInfo(info: ChildViewDataModel)
}

class ParentDashboardHeaderView: UITableViewHeaderFooterView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewStudent: UICollectionView!
    var dataSource: [ChildViewDataModel] = []
    weak var delegate: ParenParentDashboardHeaderViewProtocol?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.collectionViewStudent.register(UINib(nibName: "ChildCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ChildCollectionViewCell")

        collectionViewStudent.delegate = self
        collectionViewStudent.dataSource = self
        collectionViewStudent.reloadData()
    }
    
    func bind(data: [ChildViewDataModel]){
        self.dataSource = data
        collectionViewStudent.reloadData()
    }
    
    //MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 136.0
        let yourHeight = Double(collectionViewStudent.bounds.height)-10
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChildCollectionViewCell", for: indexPath) as! ChildCollectionViewCell
        cell.config(model: self.dataSource[indexPath.row])
        self.addShadowForView(myView: cell)
        cell.viewContent.layer.cornerRadius = 10
        cell.viewContent.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.childSelectedWithInfo(info: self.dataSource[indexPath.row])
    }
    
    func addShadowForView(myView: UIView){
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

}


