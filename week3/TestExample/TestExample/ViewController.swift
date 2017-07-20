//
//  ViewController.swift
//  TestExample
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let optionSet: UIControlState = [UIControlState.normal, UIControlState.disabled]
        
        optionSet.contains(.normal) // true
        optionSet.contains(.highlighted) // false
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

