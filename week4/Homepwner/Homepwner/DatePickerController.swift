//
//  DatePickerController.swift
//  Homepwner
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class DatePickerController : UIViewController {
    var item : Item!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date as NSDate
    }
}


