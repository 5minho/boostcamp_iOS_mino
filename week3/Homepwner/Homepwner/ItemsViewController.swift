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
    var itemsArrayClassifiedBy50Dollor: [ItemStore]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsArrayClassifiedBy50Dollor = [ItemStore(empty: true), ItemStore(empty: true)]
        classifyBy50Dollor()
        
        let footerCell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableVuewCell")
        footerCell.heightAnchor.constraint(equalToConstant: 44).isActive = true
        footerCell.textLabel?.text = "No more items!"
        self.tableView.tableFooterView = footerCell
        self.tableView.rowHeight = 60
        let backgroundImage = UIImage(named: "background")
        self.tableView.backgroundView = UIImageView(image: backgroundImage)
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    func classifyBy50Dollor() {
        for item in itemStore.allItems {
            if item.valueInDollars > 50 {
                itemsArrayClassifiedBy50Dollor[0].allItems.append(item)
            } else {
                itemsArrayClassifiedBy50Dollor[1].allItems.append(item)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return itemsArrayClassifiedBy50Dollor.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Higher Than $50" : "others"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
//        let item = itemStore.allItems[indexPath.row]
        let item = itemsArrayClassifiedBy50Dollor[indexPath.section].allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.textLabel?.font = cell.textLabel?.font.withSize(20)
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(20)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArrayClassifiedBy50Dollor[section].allItems.count
    }
    
}
