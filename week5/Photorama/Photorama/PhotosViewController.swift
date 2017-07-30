//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class PhotosViewController : UIViewController {
    @IBOutlet var collectionView : UICollectionView!
    var store : PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        store.fetchRecentPhotos() { photosResult in
            DispatchQueue.main.async {
                switch photosResult {
                case let .Success(photos):
                    print("Successfully found \(photos.count) recent photos")
                    self.photoDataSource.photos = photos
                
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destination = segue.destination as! PhotoInfoViewController
                destination.photo = photo
                destination.store = store
            }
        }
    }
}

extension PhotosViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo: photo) { result in
            DispatchQueue.main.async {
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.update(with: photo.image)
                }
            }
        }
    }
}
