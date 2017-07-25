//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class HistoryViewController : UITableViewController {
    open var recordList : RecordList = RecordList()
    let cellId = "RecordCell"
    
    override func viewDidLoad() {
        //tableView.register(UITableViewCell(, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
                return UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellId)
            }
            return cell
        }()
        let record = recordList.index(at: indexPath.row)
        cell.textLabel?.text = record.elapsedTimeFormatted()
        cell.detailTextLabel?.text = record.name + " " + record.dateRecorded
        return cell
    }
}
