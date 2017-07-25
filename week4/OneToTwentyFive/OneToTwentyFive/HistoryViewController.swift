//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class HistoryViewController : UIViewController {
    open var recordList : RecordList = RecordList()
    fileprivate let cellId = "RecordCell"
    
    fileprivate var tableView : UITableView! = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    fileprivate var footerView: UIView! = {
        var footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.backgroundColor = UIColor.orange
        return footerView
    }()
    
    fileprivate var closeButton : UIButton! = {
        var closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeScreen(_:)), for: .touchUpInside)
        return closeButton
    }()
    
    fileprivate var resetButton : UIButton! = {
        var resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(resetRecordList(_:)), for: .touchUpInside)
        return resetButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        recordList = appDelegate.recordList
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(footerView)
        view.addConstraints(tableViewConstraints())
        view.addConstraints(footerViewConstraints())
        
        footerView.addSubview(closeButton)
        footerView.addSubview(resetButton)
        footerView.addConstraints(closeButtonConstraints())
        footerView.addConstraints(resetButtonConstraints())
    }
}

//MARK:- autoLayout & target method
extension HistoryViewController {
    @objc fileprivate func closeScreen(_ button : UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func resetRecordList(_ button : UIButton) {
        guard !recordList.isEmpty() else {
            print("asd")
            return
        }
        recordList.clear()
        tableView.reloadData()
    }
    
    @objc fileprivate func tableViewConstraints() -> [NSLayoutConstraint] {
        let topConstarint = NSLayoutConstraint(item: tableView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        let widthConstraint = NSLayoutConstraint(item: tableView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: tableView,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: tableView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -60)
        return [topConstarint, widthConstraint, bottomConstraint, centerXConstraint]
    }
    
    @objc fileprivate func footerViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: footerView,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: -60)
        let bottomConstraint = NSLayoutConstraint(item: footerView,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        let widthConstraint = NSLayoutConstraint(item: footerView,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: footerView,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        return [topConstraint, bottomConstraint, widthConstraint, centerXConstraint]
    }
    @objc fileprivate func closeButtonConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: closeButton,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: closeButton,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerX,
                                                   multiplier: 0.5,
                                                   constant: 0)
        let heightConstrinat = NSLayoutConstraint(item: closeButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: footerView,
                                                  attribute: .height,
                                                  multiplier: 0.8,
                                                  constant: 0)
        return [centerYConstraint, centerXConstraint, heightConstrinat]
    }
    
    @objc fileprivate func resetButtonConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: resetButton,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: resetButton,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerX,
                                                   multiplier: 1.5,
                                                   constant: 0)
        let heightConstrinat = NSLayoutConstraint(item: resetButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: footerView,
                                                  attribute: .height,
                                                  multiplier: 0.8,
                                                  constant: 0)
        return [centerYConstraint, centerXConstraint, heightConstrinat]
    }

}

//MARK:- tableview datasource method
extension HistoryViewController : UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
