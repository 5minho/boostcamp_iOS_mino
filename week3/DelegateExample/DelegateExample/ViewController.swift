//
//  ViewController.swift
//  DelegateExample
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var two: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        textField.delegate = Superman.shared
//        two.delegate = Superman.shared
        
        self.tableView.dataSource = Superman.shared
        self.tableView.delegate = Superman.shared
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

