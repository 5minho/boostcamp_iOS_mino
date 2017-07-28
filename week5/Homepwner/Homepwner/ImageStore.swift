//
//  ImageStore.swift
//  Homepwner
//
//  Created by 오민호 on 2017. 7. 28..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit


class ImageStore {
    private let cache = NSCache<NSString, AnyObject>()
    
    open func setImage(image: UIImage, forKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
    
    open func image(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key) as? UIImage
    }
    
    open func deleteImage(forKey key: NSString) {
        cache.removeObject(forKey: key)
    }
}
