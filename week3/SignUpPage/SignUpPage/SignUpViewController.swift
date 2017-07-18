//
//  ViewController.swift
//  SignUpPage
//
//  Created by 오민호 on 2017. 7. 9..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate
, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    /* 적절한 접근권한 줘보기 open, public, internal, fileprivate, private */
    var profileImageView : UIImageView!
    var idTextField : UITextField!
    var passwordTextField : UITextField!
    var checkPasswordTextField : UITextField!
    var profileTextView : UITextView!
    var cancelButton : MinoButton!
    var signUpButton : MinoButton!
    var containerBottomConstraint : NSLayoutConstraint!
    var profileImageWidthConstraint : NSLayoutConstraint!
    
    //MARK: - UIViewController life cycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        idTextField = UITextField()
        passwordTextField = UITextField()
        checkPasswordTextField = UITextField()
        profileTextView = UITextView()
        cancelButton = MinoButton()
        signUpButton = MinoButton()
        
        profileImageView = {
            [unowned self] in
            
            let imageView: UIImageView = UIImageView()
            
            imageView.isUserInteractionEnabled = true
            imageView.backgroundColor = .black
            
            let profileImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.selectProfileImageFromPhotoLibrary(gestureRecognizer:)))
            profileImageTapRecognizer.numberOfTapsRequired = 1
            imageView.addGestureRecognizer(profileImageTapRecognizer)
            
            return imageView
        }()

        //MARK: - 프로필 이미지 뷰 속성 세팅
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = UIColor.black
        
        let profileImageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectProfileImageFromPhotoLibrary(gestureRecognizer:)))
        profileImageTapRecognizer.numberOfTapsRequired = 1
        profileImageView.addGestureRecognizer(profileImageTapRecognizer)
        
        //MARK: - 텍스트 필드 속성 세팅
        idTextField.placeholder = "ID"
        idTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        checkPasswordTextField.placeholder = "Check Password"
        checkPasswordTextField.borderStyle = .roundedRect
        checkPasswordTextField.isSecureTextEntry = true
        
        idTextField.delegate = self
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        //MARK: - 취소, 등록 버튼 세팅
        cancelButton.setTitle(title: "Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.red, for: .normal)
        cancelButton.setTitleColor(UIColor.white, for: .highlighted)
        cancelButton.setTitleColor(UIColor.red, for: .selected)
        cancelButton.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        
        signUpButton.setTitle(title: "Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.blue, for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .highlighted)
        cancelButton.setTitleColor(UIColor.blue, for: .selected)
        signUpButton.addTarget(self, action: #selector(signUp(_:)), for: .touchUpInside)
        
        //MARK: - 텍스트뷰 세팅
        profileTextView.backgroundColor = UIColor.cyan
        profileTextView.delegate = self
        

        //        setUpImageView()
        // setUpImageView 대신에 이렇게 해보는 것은 어떨런지
        
        
        view.addSubview(profileImageView)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(checkPasswordTextField)
        view.addSubview(profileTextView)
        view.addSubview(cancelButton)
        view.addSubview(signUpButton)
        
        let backgroundTapped = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard(gestureRecognizer:)))
        backgroundTapped.numberOfTapsRequired = 1
        backgroundTapped.cancelsTouchesInView = false
        view.addGestureRecognizer(backgroundTapped)
        defineConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyboardWillShowNotification(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyboardWillHideNotification(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    

    // MARK: - Notifications
    func didReceiveKeyboardWillShowNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    func didReceiveKeyboardWillHideNotification(notification: NSNotification) {
        updateBottomLayoutConstraintWithNotification(notification: notification)
    }
    
    func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
        let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).uint32Value << 16
        let animationCurve = UIViewAnimationOptions(rawValue: UInt(rawAnimationCurve))
    
        containerBottomConstraint.constant = -(view.bounds.maxY - convertedKeyboardEndFrame.minY)
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: [.beginFromCurrentState ,animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: - backgroundTap     
    func dismissKeyBoard(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - textField and textView delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - method for selecting profile image
    func selectProfileImageFromPhotoLibrary(gestureRecognizer: UIGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        //기기에 카메라가 있으면 사진을 찍는다
        //아니면 사진 라이브러리에서 사진을 고른다
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        view.endEditing(true)
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let profileImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImageView.image = profileImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - target actions of button
    func cancel(_ button: MinoButton) {
        view.endEditing(true)
        presentingViewController?.dismiss(animated: true)
    }
    
    func signUp(_ button: MinoButton) {
        view.endEditing(true)
        if passwordTextField.text!.isEmpty || checkPasswordTextField.text!.isEmpty
            || (passwordTextField.text! != checkPasswordTextField.text!) {return}
        presentingViewController?.dismiss(animated: true)
    }
    
    
    //MARK: - view 제약사항 정의
    func offTranslatesAutoresizingMaskIntoConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        checkPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        profileTextView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func defineConstraint() {
        let space : CGFloat = 8.0
        offTranslatesAutoresizingMaskIntoConstraints()
        profileImageWidthConstraint = profileImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: space)
        profileImageWidthConstraint.isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier : 0.29, constant : 0).isActive = true
        
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
        
        cancelButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/11).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.bounds.width / 4).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        
        
        containerBottomConstraint = cancelButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -space)
        containerBottomConstraint.isActive = true
        
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.bounds.width / 4).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor).isActive = true
    }
    
    //MARK: - 가로모드일때 constraint 수정
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.view.traitCollection.verticalSizeClass == .compact {
            
        }
    }
}

