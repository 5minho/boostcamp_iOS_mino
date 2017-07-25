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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: NSNumber(value : item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
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
}

extension DetailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
