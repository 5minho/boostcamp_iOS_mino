//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class PhotosViewController : UIViewController {
    @IBOutlet var imageView : UIImageView!
    var store : PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchRecentPhotos() { photosResult in
            switch photosResult {
            case let .Success(photos) :
                print("Successfully found \(photos.count) recent photos.")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(photo: firstPhoto) { imageResult in
                        switch imageResult {
                        case let .Success(image) :
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        case let .Failure(error) :
                            print("Error downloading image: \(error)")
                        }
                    }
                }
            case let .Failure(error) :
                print("Error fetching recent photos : \(error)")
            }
        }
    }
}
