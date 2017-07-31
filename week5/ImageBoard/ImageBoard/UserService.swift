//
//  User.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

// To Do : request 메서드간 중복 코드 줄이기

class UserService {
    
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
    
}
