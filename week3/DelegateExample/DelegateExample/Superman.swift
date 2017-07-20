//
//  Superman.swift
//  DelegateExample
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit



class Superman: NSObject, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    static let shared = Superman()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = indexPath.description
        return cell
    }
    
}

