//
//  ViewController.swift
//  LoginScreen
//
//  Created by 오민호 on 2017. 7. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: UIButton) {
        guard let id = txtID.text else {return}
        guard let pw = txtPassword.text else {return}
        
        print("touch up inside - sign in")
        print("ID : " + id + ", PW : " + pw)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        print("touch up inside - sign up")
    }
}

