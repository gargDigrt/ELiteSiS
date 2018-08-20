//
//  GalleryPhotosViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

struct ImageItem {
    let name: String?
    let image: UIImage
    
    init(name: String?, image: UIImage) {
        self.name = name
        self.image = image
    }
}

class GalleryPhotosViewController: UIViewController{
    
    //IBOutlet
    @IBOutlet weak var lblPhotoName: UILabel!
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    //Variables
    var albumID:String!
    var gallery: [ImageItem] = []
    var arrPhotos:[String]!
    var index = 0
    

    //MARK:- View's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getImagesFor(albumID: albumID)
        arrPhotos = ["student_group","classroom","school"]
        
        configureImageCollectionView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblPhotoName.text = "Gallery"
    }
    
    //MARK:- Custom method
    
    func getImagesFor(albumID aId : String) {
        ProgressLoader.shared.showLoader(withText: "Loading images")
        
        WebServices.shared.getImagesForAlbum(withId: aId, completion: { (response, error) in
            if error == nil , let responseDict = response {
                let images = responseDict["value"].arrayValue
                
                for item in images {
                    let name = item["filename"].string
                    if let imgString = item["documentbody"].string {
                        let image = UIImage.decodeBase64(toImage: imgString)
                        let imgItem = ImageItem(name: name, image: image)
                        self.gallery.append(imgItem)
                    }
                }
                self.collectionViewPhotos.reloadData()
            }else{
                AlertManager.shared.showAlertWith(title: "Error!", message: "Somthing went wrong")
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
            ProgressLoader.shared.hideLoader()
        })
    }
    
    fileprivate func configureImageCollectionView() {
        collectionViewPhotos.register(UINib(nibName:"GalleryPhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryPhotosCollectionViewCell")
        collectionViewPhotos.delegate = self
        collectionViewPhotos.dataSource = self
    }
    
    //MARK:- Button action
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- UICollection view delegate and datasource

extension GalleryPhotosViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - 60
        return CGSize(width:width, height:height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryPhotosCollectionViewCell", for: indexPath) as! GalleryPhotosCollectionViewCell
        cell.imgView.image = gallery[indexPath.row].image
        return cell
    }
    
}

//MARK:- UIScrollview delegate
extension GalleryPhotosViewController {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(collectionViewPhotos.contentOffset.x / collectionViewPhotos.frame.size.width)
//        if let imgName = gallery[currentIndex].name {
//            let finalName = imgName.split(separator: ".").first
//            lblPhotoName.text = finalName!
//        }
    }
    
}

