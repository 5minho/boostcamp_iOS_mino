//
//  User.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

// To Do : request 메서드간 중복 코드 줄이기
//       : error 처리

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum ImageError : Error {
    case ImageCreationError
}

enum ImageSize {
    case thumbnail
    case detail
}

class UserService {
    
    static let shared = UserService()
    
    private init() {
        
    }
    
    enum SignUpResult : Int {
        case ok = 201
        case incorrect = 404
        case emailDuplication = 406
    }
    
    enum LoginResult : Int {
        case ok = 200
        case unauthorized = 401
    }

    func requestSignUp (email: String, password : String, nickName: String, completion : @escaping (SignUpResult, Data?) -> Void ) {
        guard let url = ImageBoardAPI.signUpURL() else { return }
        var request = URLRequest(url: url)
        let param = ["email" : email, "password" : password, "nickName" : nickName]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                guard let statusCode = SignUpResult(rawValue: httpResponse.statusCode)
                    else {return}
                completion(statusCode, data)
            }
        }
        task.resume()
    }

    func requestLogin(email : String, password : String, completion : @escaping (LoginResult, Data?) -> Void) {
        guard let url = ImageBoardAPI.loginURL() else { return }
        var request = URLRequest(url: url)
        let param = ["email" : email, "password" : password]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                guard let statusCode = LoginResult(rawValue: httpResponse.statusCode)
                    else {return}
                completion(statusCode, data)
            }
        }
        task.resume()
    }
    
    func fetchArticles(completion : @escaping (ArticleResult) -> Void) {
        guard let url = ImageBoardAPI.fetchArticleURL() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let result = self.processRecentArticlesRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    func processRecentArticlesRequest(data : Data?, error: Error?) -> ArticleResult {
        guard  let jsonData = data else {
            return .failure(error!)
        }
        return ImageBoardAPI.articles(from: jsonData)
    }
    
    func fetchImageForArticle(article : Article, size : ImageSize, completion: @escaping (ImageResult) -> Void) {
        var url : URL
        switch size {
        case .thumbnail:
            url = ImageBoardAPI.resourceURL(for: article.thumbURL)!
        case .detail:
            url = ImageBoardAPI.resourceURL(for: article.imageURL)!
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                article.thumbImage = image
            }
            completion(result)
        }
        task.resume()
    }
    
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageError.ImageCreationError)
                }
        }
        return .success(image)
    }
}
