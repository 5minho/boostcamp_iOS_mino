//
//  SignUpViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

enum SignUpResult {
    case success
    case failure(HTTPURLResponse)
}

class SignUpViewController : UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    var signUpSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        guard shouldInputAllItems() else {
            self.resultLabel.text = "failure"
            return
        }
        
        guard shouldCheckPassword() else {
            self.resultLabel.text = "failure"
            return
        }
        
        signUpAPI(email: emailField.text!, password: pwField.text!, nickName: nickNameField.text!) { [unowned self]result in
            DispatchQueue.main.async {
                switch result {
                case .success :
                    self.resultLabel.text = "success"
                case let .failure(httpResponse):
                    self.resultLabel.text = "failure \(httpResponse.statusCode)"
                }
            }
        }
    }
    
    func shouldInputAllItems() -> Bool {
        guard let email = emailField.text else { return false }
        guard let nickName = nickNameField.text else { return false }
        guard let pw = pwField.text else { return false }
        guard let checkPw = pwCheckField.text else { return false }
        
        return !email.isEmpty && !nickName.isEmpty && !pw.isEmpty && !checkPw.isEmpty
    }
    
    func shouldCheckPassword() -> Bool {
        guard let pw = pwField.text else {return false}
        guard let checkPw = pwCheckField.text else {return false}
        return pw == checkPw && !pw.isEmpty && !checkPw.isEmpty
    }
    
    func signUpAPI(email: String,
                 password : String,
                 nickName: String,
                 completion : @escaping (SignUpResult) -> Void ) {
        
        guard let url = signUpURL() else { return }
        
        var request = URLRequest(url: url)
        let param = ["email" : email, "password" : password, "nickname" : nickName]
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if httpResponse.statusCode == 201 {
                completion(.success)
                return
            }
            completion(.failure(httpResponse))
        }
        task.resume()
    }
    
    func signUpURL() -> URL? {
        let baseURLString = "https://ios-api.boostcamp.connect.or.kr"
        return URL(string: baseURLString + "/user")
    }
}
