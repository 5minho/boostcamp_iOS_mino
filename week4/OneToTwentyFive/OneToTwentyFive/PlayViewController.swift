//
//  ViewController.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 22..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    private var level = 5
    
    private var topRecodeLabel : UILabel!
    
    private var currentTopRecord : UILabel! = {
        var currentTopRecord = UILabel()
        currentTopRecord.text = "--:--:--"
        return currentTopRecord
    }()
    
    private var startButton : UIButton!
    private var numberButtons : [UIButton]!
    private var isSetConstraints : [Bool]!
    private let space : CGFloat = 8.0
    //footerView 를 쓰는 화면이 많아서 재사용할 방법을 찾아보자
//    private var footerView : UIView! = {
//        var footerView = UIView()
//        return footerView
//    }()
//    
//    private var homeButton : UIButton! = {
//        var homeButton = UIButton()
//        homeButton.setTitle("HOMR", for: .normal)
//        return homeButton
//    }()
//    
//    private var historyButton : UIButton! = {
//        var historyButton = UIButton()
//        historyButton.setTitle("HISTORY", for: .normal)
//        return historyButton
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton = UIButton(type : .system)
        startButton.backgroundColor = UIColor.orange
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: space).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -space).isActive = true
        startButton.heightAnchor.constraint(equalTo: startButton.widthAnchor).isActive = true
        let randomNumberList = makeRandomNumberList(to : level * level)
        let multiplier = CGFloat(1 / CGFloat(level + 1))
        numberButtons = [UIButton]()
        let cellWidth  = (view.bounds.width - 2 * space) * multiplier
        var idx = 0
        
        for row in 0 ..< level {
            for col in 0 ..< level {
                let cell = UIButton()
                cell.translatesAutoresizingMaskIntoConstraints = false
                cell.backgroundColor = UIColor.blue
                cell.setTitle("\(randomNumberList[idx])", for: .normal)
                idx += 1
                startButton.addSubview(cell)
                let topConstraint = NSLayoutConstraint(item: cell,
                                                       attribute: .top,
                                                       relatedBy: .equal,
                                                       toItem: startButton,
                                                       attribute: .top,
                                                       multiplier: 1,
                                                       constant: CGFloat(1 + row) * space + CGFloat(row) * cellWidth)
                let bottomConstraint = NSLayoutConstraint(item: cell,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: startButton,
                                                          attribute: .bottom,
                                                          multiplier: 1,
                                                          constant: -(CGFloat(level - row) * space + CGFloat(level - row - 1) * cellWidth))
                let leadingConstraint = NSLayoutConstraint(item: cell,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: startButton,
                                                           attribute: .leading,
                                                           multiplier: 1,
                                                           constant: CGFloat(1 + col) * space + CGFloat(col) * cellWidth)
                let trailingConstraint = NSLayoutConstraint(item: cell,
                                                            attribute: .trailing,
                                                            relatedBy: .equal,
                                                            toItem: startButton,
                                                            attribute: .trailing,
                                                            multiplier: 1,
                                                            constant: -(CGFloat(level - col) * space + CGFloat(level - col - 1) * cellWidth))
                startButton.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
                numberButtons.append(cell)
            }
        }
    }
    
    func makeRandomNumberList(to upperBound: Int) -> [Int] {
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count != (upperBound) {
            randomNumberSet.insert(Int(arc4random_uniform(UInt32(upperBound))) + 1)
        }
        return Array(randomNumberSet)
    }
    
    private func numberButtonContstrints(button : UIButton , index : Int) {
        
    }
}

