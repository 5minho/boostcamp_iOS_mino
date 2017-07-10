//
//  ViewController.swift
//  SignUpPage
//
//  Created by 오민호 on 2017. 7. 9..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
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
        setUpTextView()
        
        view.addSubview(profileImageView)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(checkPasswordTextField)
        view.addSubview(profileTextView)
        view.addSubview(cancelButton)
        view.addSubview(signUpButton)
        
        let backgroundTapped = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(gestureRecognizer:)))
        backgroundTapped.numberOfTapsRequired = 1
        view.addGestureRecognizer(backgroundTapped)
        
        setTranslatesAutoresizingMaskIntoConstraints()
        createConstraint()
    }
    
    func dismissKeyBoard(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func selectProfileImageFromPhotoLibrary(gestureRecognizer: UIGestureRecognizer) {
            print("selectProfileImageFromPhotoLibrary")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" { textView.resignFirstResponder() }
        return true
    }
    
    // mark : initial set up view components
    
    private func setUpImageView() {
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = UIColor.black
        
        let profileImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectProfileImageFromPhotoLibrary(gestureRecognizer:)))
        profileImageTapRecognizer.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(profileImageTapRecognizer)
        
    }
    
    private func setUpTextView() {
        profileTextView.backgroundColor = UIColor.gray
        profileTextView.delegate = self
    }
    
    private func setUpTextField() {
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        checkPasswordTextField.placeholder = "Check Password"
        checkPasswordTextField.borderStyle = .roundedRect
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
    }
    
    private func setUpButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .highlighted)
        cancelButton.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.blue, for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .highlighted)
        signUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
    }
    
    private func setTranslatesAutoresizingMaskIntoConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        checkPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        profileTextView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // mark : create and activate constraint
    
    private func createConstraint() {
        let space : CGFloat = 8.0
        
        profileImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: space).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 1/3, constant : 0).isActive = true
        
        idTextField.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        idTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: space).isActive = true
        idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: idTextField.heightAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: idTextField.widthAnchor).isActive = true
        
        checkPasswordTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor).isActive = true
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
    
    // mark : target actions of button
    
    func cancel(_ button: UIButton) {
        presentingViewController?.dismiss(animated: true)
    }
    
    func signUp(_ button: UIButton) {
        presentingViewController?.dismiss(animated: true)
    }

}

