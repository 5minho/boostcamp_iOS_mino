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

enum LoginResult {
    case success(User)
    case failure(Int, String)
}

enum ImageError : Error {
    case ImageCreationError
}

enum ImageSize {
    case thumbnail
    case detail
}

enum PostResult {
    case success
    case failure(Error)
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}


class UserService {
    
    static let shared = UserService()
    var loginSession : URLSession? = nil
    
    private init() {}
    
    enum SignUpResult : Int {
        case ok = 201
        case incorrect = 404
        case emailDuplication = 406
    }

    func signUp (email: String,
                 password : String,
                 nickName: String,
                 completion : @escaping (SignUpResult, Data?) -> Void ) {
        guard let url = ImageBoardAPI.signUpURL() else { return }
        var request = URLRequest(url: url)
        let param = ["email" : email, "password" : password, "nickname" : nickName]
        
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

    func login(email : String,
               password : String,
               completion : @escaping (LoginResult) -> Void) {
        guard let url = ImageBoardAPI.loginURL() else { return }
        var request = URLRequest(url: url)
        let param = ["email" : email, "password" : password]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        
        loginSession = URLSession(configuration: .default)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let task = loginSession?.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                guard let userData = data else { return }
                let user = ImageBoardAPI.user(from: userData)
                if user != nil {
                    completion(.success(user!))
                } else {
                    completion(.failure(httpResponse.statusCode, "Message : unauthorized"))
                }
            }
        }
        appDelegate?.loginSession = loginSession
        task?.resume()
    }
    
    func post(title : String,
              desc : String,
              imageData : Data ,
              completion: @escaping (PostResult) -> Void) {
        guard let url = ImageBoardAPI.postImageURL() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        let param = ["image_title" : title, "image_desc" : desc]
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: param,
                                boundary: boundary,
                                data: imageData,
                                mimeType: "image/jpeg",
                                filename: "article.jpg")
        
        let task = loginSession?.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if httpResponse.statusCode == 201 {
                    completion(.success)
                }
            }
        }
        task?.resume()
    }
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"image_data\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
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
    
    func fetchImageForArticle(article : Article,
                              size : ImageSize,
                              completion: @escaping (ImageResult) -> Void) {
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
