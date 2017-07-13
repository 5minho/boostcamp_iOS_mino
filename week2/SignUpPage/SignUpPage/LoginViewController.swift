//
//  SignInViewController
//  LoginScreen
//
//  Created by 오민호 on 2017. 7. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    lazy var signUpViewController = { () -> SignUpViewController in 
        let viewController = SignUpViewController()
        print("create signUpViewController")
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_sender: AnyObject) {
        idField.resignFirstResponder()
        passwordField.resignFirstResponder()
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        guard let id = idField.text else {return}
        guard let pw = passwordField.text else {return}
        
        print("touch up inside - sign in")
        print("ID : " + id + ", PW : " + pw)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        present(signUpViewController, animated: true)
    }
}

