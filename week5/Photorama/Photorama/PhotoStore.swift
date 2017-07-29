//
//  PhotoStore.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError : Error {
    case ImageCreationError
}


class PhotoStore {
    let session : URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion : @escaping (PhotoResult) -> Void) {
        guard let url = FlickrAPI.recentPhotosURL() else {return}
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error  in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                httpResponse.allHeaderFields.keys.forEach({
                    print($0)
                })
            }
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentPhotosRequest(data : Data?, error: Error?) -> PhotoResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        return FlickrAPI.photos(from: jsonData)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            let result = self.processImageRequest(data: data, error: error)
            if case let .Success(image) = result {
                photo.image = image
            }
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data :Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .Failure(error!)
                } else {
                    return .Failure(PhotoError.ImageCreationError)
                }
        }
        return .Success(image)
    }
}
