//
//  AddAtricleViewController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class AddArticleViewController : UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setPhotoFromLibrary(_ sender: UITapGestureRecognizer) {
        titleField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        guard let title = titleField.text else {return}
        guard let imageDesc = imageDescription.text else {return}
        guard let image = imageView.image else {return}
        guard let imageData = UIImageJPEGRepresentation(image, 0.3) else { return }
        
        UserService.shared.post(title: title, desc: imageDesc, imageData: imageData) { postResult in
            print(postResult)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddArticleViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
