//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class PhotoInfoViewController : UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photo : Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store : PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImageForPhoto(photo: photo) { result in
            switch result {
            case let .Success(image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo\(error)")
            }
        }
    }
}
