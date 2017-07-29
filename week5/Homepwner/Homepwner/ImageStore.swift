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
        
        if let imageURL = imageURLForKey(key: key),
            let data = UIImagePNGRepresentation(image) {
            do {
                try data.write(to: imageURL)
            } catch {
                
            }
        }
    }
    
    open func image(forKey key: NSString) -> UIImage? {
        if let existingImage = cache.object(forKey: key) as? UIImage {
            return existingImage
        }
        
        guard let imageURL = imageURLForKey(key: key)
            else {
                return nil
        }
        
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path)
            else {
                return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key)
        return imageFromDisk
        
    }
    
    open func deleteImage(forKey key: NSString) {
        cache.removeObject(forKey: key)
    }
    
    func deleteImageForKey(key: NSString) {
        cache.removeObject(forKey: key)
        
        if let imageURL = imageURLForKey(key: key) {
            do {
                try FileManager.default.removeItem(at: imageURL)
            } catch let deleteError {
                print("Error removing the image from disk: \(deleteError)")
            }
        }
    }
    
    func imageURLForKey(key: NSString) -> URL? {
        let documentsDirectoris = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectoris.first
        return documentDirectory?.appendingPathComponent(key as String)
    }
}
