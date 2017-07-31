//
//  SignUpViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

//To do 1. alert하는 부분 모듈화
//      2. 네트워크 통신 부분 모듈화
//      3. pop하고 alert하는 코드 수정하기 (viewControllers[0] 부분도)
class SignUpViewController : UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var nickNameField: UITextField!
    
    @IBOutlet weak var pwField: UITextField!
    
    @IBOutlet weak var pwCheckField: UITextField!
    
    var signUpSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        guard shouldInputAllItems() else {
            //alert
            let alert = UIAlertController(title: "모든 항목을 입력해주세요", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        guard shouldCheckPassword() else {
            //alert
            let alert = UIAlertController(title: "암호와 암호확인이 일치하지 않습니다.", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return
        }
        if  let email = emailField.text ,
            let nickName = nickNameField.text,
            let password = pwField.text {
            let service = UserService()
            
            service.requestSignUp(email: email, password: nickName, nickName: password) { result, data in
                DispatchQueue.main.async {
                    switch result {
                    case .ok :
                        let loginViewControllerVC = self.navigationController?.viewControllers[0] as? LoginViewController
                        loginViewControllerVC?.signUpSuccess = true
                        self.signUpSuccess = true
                        self.navigationController?.popViewController(animated: true)
                
                    case .emailDuplication:
                        guard let data = data, let message = String(data: data, encoding: .utf8) else {return}
                        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
                        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: false, completion: nil)
                        
                    case .incorrect :
                        print("incorrect")
                    }
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
        return pw == checkPw
    }
}
