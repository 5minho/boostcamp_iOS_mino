//
//  DetailViewController.swift
//  Homepwner
//
//  Created by 오민호 on 2017. 7. 24..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var nameField: MyTextField!
    @IBOutlet weak var serialNumberField: MyTextField!
    @IBOutlet weak var valueField: MyTextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let numberFormatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    var item: Item!  {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore : ImageStore!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value : item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        let key = item.itemKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
        
    }

    
    @IBAction func backgroungTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker : UIImagePickerController = {
            [unowned self] in
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
            } else {
                imagePicker.sourceType = .photoLibrary
            }
            
            return imagePicker
        }()
        
        present(imagePicker, animated: true, completion: nil)
    }
}

extension DetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeDate" {
            let datePickerController = segue.destination as! DatePickerController
            datePickerController.item = item
        }
    }
}


extension DetailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        imageStore.setImage(image: image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
}

