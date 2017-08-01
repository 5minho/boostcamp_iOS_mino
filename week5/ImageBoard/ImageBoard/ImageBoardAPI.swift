//
//  BoostCampAPI.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

enum ArticleResult {
    case success([Article])
    case failure(Error)
}

enum ImageBoardError : Error {
    case invalidJSONData
}


struct ImageBoardAPI {
    private static let baseURLString = "https://ios-api.boostcamp.connect.or.kr"
    private static let dateFormatter : DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    static func signUpURL() -> URL? {
        return URL(string: baseURLString + "/user")
    }
    
    static func loginURL() -> URL? {
        return URL(string: baseURLString + "/login")
    }
    
    static func fetchArticleURL() -> URL? {
        return URL(string: baseURLString + "/")
    }
    
    static func resourceURL(for stringURL : String) -> URL? {
        return URL(string: baseURLString + stringURL)
    }
    
    static func postImageURL() -> URL? {
        return URL(string: baseURLString + "/image")
    }
    
    static func user(from data : Data) -> User? {
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let userData = jsonObject as? [String : AnyObject] else { return nil }
        guard let id = userData["_id"] as? String,
            let email = userData["email"] as? String else{
                return nil
        }
        return User(id: id, email: email)
    }
    
    static func articles(from jsonData: Data) -> ArticleResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            guard let articles = jsonObject as? [[String : AnyObject]] else {
                return .failure(ImageBoardError.invalidJSONData)
            }
            
            var articleList = [Article]()
            articles.forEach({
                if let article = article(from: $0) {
                    articleList.append(article)
                }
            })
            
            if articleList.count == 0 && articles.count > 0 {
                return .failure(ImageBoardError.invalidJSONData)
            }
            return .success(articleList)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func article(from jsonObject : [String : AnyObject]) -> Article? {
        guard let id = jsonObject["_id"] as? String,
        let authorId = jsonObject["author"] as? String,
        let authorNickName = jsonObject["author_nickname"] as? String,
        let timeStamp = jsonObject["created_at"] as? Int,
        let imageDesc = jsonObject["image_desc"] as? String,
        let imageTitle = jsonObject["image_title"] as? String,
        let imageURL = jsonObject["image_url"] as? String,
            let thumbURL = jsonObject["thumb_image_url"] as? String else {
                return nil
        }
        let dateCreated = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timeStamp)))
        return Article(id: id, dateCreated: dateCreated, thumbURL: thumbURL, imageURL: imageURL, authorNickName: authorNickName, authorId: authorId, imageDescription: imageDesc, imageTitle: imageTitle)
    }
}
