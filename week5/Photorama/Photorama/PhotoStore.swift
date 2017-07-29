//
//  PhotoStore.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class PhotoStore {
    let session : URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos() {
        guard let url = FlickrAPI.recentPhotosURL() else {return}
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error  in
            if let jsonData = data {
                if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
//                    print(jsonString)
                }
            } else if let requestError = error {
                print("Error fetching recent photos: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
        }
        task.resume()
    }
}
