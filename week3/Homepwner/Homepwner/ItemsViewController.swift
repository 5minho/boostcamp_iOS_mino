//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by 오민호 on 2017. 7. 14..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
}
