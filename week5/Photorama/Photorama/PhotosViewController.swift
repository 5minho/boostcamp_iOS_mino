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
        store.fetchRecentPhotos()
    }
}
