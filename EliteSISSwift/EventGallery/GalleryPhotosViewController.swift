//
//  GalleryPhotosViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class GalleryPhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var arrPhotos:[String]!
    var index = 0
    var arrNames = ["Group Photo", "Classroom", "School"]
    @IBOutlet weak var lblPhotoName: UILabel!
    
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrPhotos = ["student_group","classroom","school"]
        collectionViewPhotos.register(UINib(nibName:"GalleryPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryPhotosCollectionViewCell")
        collectionViewPhotos.delegate = self
        collectionViewPhotos.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblPhotoName.text = arrNames[index]
        DispatchQueue.main.async {
            self.collectionViewPhotos.scrollToItem(at: IndexPath(item:self.index, section:0), at:.right, animated: false)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - 60
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryPhotosCollectionViewCell", for: indexPath) as! GalleryPhotosCollectionViewCell
            cell.imgView.image = UIImage(named:"student_group")
            
           return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryPhotosCollectionViewCell", for: indexPath) as! GalleryPhotosCollectionViewCell
            cell.imgView.image = UIImage(named:"classroom")
            
           return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryPhotosCollectionViewCell", for: indexPath) as! GalleryPhotosCollectionViewCell
            cell.imgView.image = UIImage(named:"school")
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(collectionViewPhotos.contentOffset.x / collectionViewPhotos.frame.size.width)
        lblPhotoName.text = arrNames[currentIndex]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
