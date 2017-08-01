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
        
        // 메서드 이름은 setPhotoFromLibray 인데, 텍스트 필트를 resign 시키는 기능이 들어있는 것은
        // 차후에 예상치 못한 동작들을 유발할 가능성이 있어 보입니다.
        // 예제라 크게 문제 없겠지만, 실전이라면 나중에 나 또는 다른사람이 내 코드를 운용할 때 문제가 발생할 여지가 있습니다.
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
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        UserService.shared.post(title: title, desc: imageDesc, imageData: imageData) { postResult in
            print(postResult)
        }
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
