//
//  FlickrAPI.swift
//  Photorama
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

enum PhotoResult {
    case Success([Photo])
    case Failure(Error)
}

enum FlickerError : Error {
    case InvalidJSONData
}

struct FlickrAPI {
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    private static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrURL(method : Method, parameters: [String:String]?) -> URL? {
        var components = URLComponents(string: baseURLString)
        var queryItems = [URLQueryItem]()
        
        let baseparams = [
            "method" : method.rawValue,
            "format" : "json",
            "nojsoncallback" : "1",
            "api_key" : APIKey
        ]
        
        for (key, value) in baseparams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components?.queryItems = queryItems
        return components?.url
    }
    
    static func recentPhotosURL() -> URL? {
        return flickrURL(method: .RecentPhotos, parameters: ["extras":"url_h,date_taken"])
    }
    
    static func photos(from jsonData: Data) -> PhotoResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let jsonDictionary = jsonObject as? [String : AnyObject],
                let photos = jsonDictionary["photos"] as? [String : AnyObject],
                let photosArray = photos["photo"] as? [[String: AnyObject]] else {
                    return .Failure(FlickerError.InvalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            photosArray.forEach({
                if let photo = photo(from: $0) {
                    finalPhotos.append(photo)
                }
            })
            
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .Failure(FlickerError.InvalidJSONData)
            }
            
            return .Success(finalPhotos)
        } catch let error {
            return .Failure(error)
        }
    }
    
    private static func photo(from jsonObject : [String : AnyObject]) -> Photo? {
        guard let photoId = jsonObject["id"] as? String,
            let title = jsonObject["title"] as? String,
            let dateString = jsonObject["datetaken"] as? String,
            let photoURLString = jsonObject["url_h"] as? String,
            let url = URL(string: photoURLString),
            let dateTaken = dateFormatter.date(from: dateString) else {
                return nil
        }
        return Photo(title: title, photoId: photoId, remoteURL: url, dateTaken: dateTaken)
    }
}
