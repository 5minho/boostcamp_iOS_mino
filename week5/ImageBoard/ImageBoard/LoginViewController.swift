//
//  ViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 7. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var signUpSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if signUpSuccess {
            let alert = UIAlertController(title: "회원가입 완료!", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: false, completion: nil)
        }
        signUpSuccess = false
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
    }

    @IBAction func signUp(_ sender: Any) {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpViewController" {
            let destination = segue.destination as! SignUpViewController
            destination.signUpSuccess = signUpSuccess
        }
    }
}

