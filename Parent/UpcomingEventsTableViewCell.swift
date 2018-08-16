//
//  UpcomingEventsTableViewCell.swift
//  EliteSISSwift
//
//  Created by PeakGeek on 21/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

protocol UpcomingEventsProtocol: class {
    func eventSelectedWithData(event: EventViewDataModel)
}

class UpcomingEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var collectionViewEvents: UICollectionView!
    var dataSource: [EventViewDataModel] = []
    weak var delegate: UpcomingEventsProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewInner.layer.cornerRadius = 8.0
        self.viewInner.layer.masksToBounds = true
        
        self.collectionViewEvents.register(UINib(nibName: "EventCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "EventCollectionViewCell")
        collectionViewEvents.delegate = self
        collectionViewEvents.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(data: [EventViewDataModel]){
        self.dataSource = data
        self.collectionViewEvents.reloadData()
    }
}

extension UpcomingEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: - Collection View Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = 150.0
        let yourHeight = Double(collectionViewEvents.bounds.height)-10
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let dataSource = self.dataSource[indexPath.row]
        cell.config(eventName: dataSource.name, color: dataSource.color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.eventSelectedWithData(event: self.dataSource[indexPath.row])
    }
}
