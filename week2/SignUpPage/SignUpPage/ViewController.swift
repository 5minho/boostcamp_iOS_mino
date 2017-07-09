//
//  ViewController.swift
//  SignUpPage
//
//  Created by 오민호 on 2017. 7. 9..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark : Properties
    
    var profileImageView : UIImageView!
    var idTextField : UITextField!
    var passwordTextField : UITextField!
    var checkPasswordTextField : UITextField!
    var profileTextView : UITextView!
    var cancelButton : UIButton!
    var signUpButton : UIButton!
    
    override func loadView() {
        super.loadView()
        
        //Mark : Create components
        profileImageView = UIImageView()
        idTextField = UITextField()
        passwordTextField = UITextField()
        checkPasswordTextField = UITextField()
        profileTextView = UITextView()
        cancelButton = UIButton()
        signUpButton = UIButton()
        
        setUpImageView()
        setUpTextField()
        setUpButton()
        
        
        view.addSubview(profileImageView)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(checkPasswordTextField)
        view.addSubview(profileTextView)
        view.addSubview(cancelButton)
        view.addSubview(signUpButton)
        
        createConstraint()
    }
    
    
    
    func setUpImageView() {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = UIColor.black
    }
    
    func setUpTextField() {
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        checkPasswordTextField.placeholder = "Check Password"
        checkPasswordTextField.borderStyle = .roundedRect
    }
    
    func setUpButton() {
        cancelButton.isEnabled = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .highlighted)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.blue, for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .highlighted)
    }
    
    func createConstraint() {
        let space : CGFloat = 8.0
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        checkPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        profileTextView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: space).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5, constant: 0).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/3, constant : 0).isActive = true
        
        idTextField.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: space).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: space).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        
        checkPasswordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
        checkPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: space).isActive = true
        checkPasswordTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        checkPasswordTextField.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        checkPasswordTextField.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        
        profileTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant : space).isActive = true
        profileTextView.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor).isActive = true
        profileTextView.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor).isActive = true
        profileTextView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -space).isActive = true
        
        
        cancelButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.width / 4).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -space).isActive = true
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.width / 4).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

