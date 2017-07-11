//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 오민호 on 2017. 7. 3..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

// 입력값 유효성 체커
// 4장 동메달 과제 : 알파벳 문자 허용하지 않기

class UnablePasteUITextFeild : UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }
        return true
    }
}
class VaildChracterSetCheker {
    var validChracterSet : CharacterSet
    
    init(from characterSet : CharacterSet) {
        self.validChracterSet = characterSet
    }
    
    func check (target string : String) -> Bool {
        return !string.isEmpty && (string.rangeOfCharacter(from: self.validChracterSet) == nil)
    }
}

class ConversionViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
    
    let validChracterSetCheker = VaildChracterSetCheker(from: CharacterSet(charactersIn : ".1234567890"))
    
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
        // 4장 동메달 과제 : 알파벳 문자 허용하지 않기
        if validChracterSetCheker.check(target: string) { return false }
        //
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        return !(existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil)
    }
    
    override func viewDidLoad() {
        print("ConversionViewController loaded its view.")
    }
    
    
    // 5장 은메달 과제 : 다크모드
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        //현재 시간
        let currentHour = Calendar.current.component(.hour, from: Date())
        print(currentHour)
        if currentHour > 8 && currentHour < 20 {
            view.backgroundColor = UIColor.yellow
        } else {
            view.backgroundColor = UIColor.darkGray
        }
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
