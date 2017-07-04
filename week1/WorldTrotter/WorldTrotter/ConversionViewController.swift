//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 오민호 on 2017. 7. 3..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 숫자, 백스페이스, 소숫점이 아니면 리턴 false
        let validChracterSet = CharacterSet(charactersIn : ".1234567890")
        if !string.isEmpty && string.rangeOfCharacter(from: validChracterSet) == nil { return false }
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        return !(existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil)
    }
    
    override func viewDidLoad() {
        print("ConversionViewController loaded its view.")
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        textField.resignFirstResponder()
    }
    
    
}
