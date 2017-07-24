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
    
    private var topRecodeLabel : UILabel! = {
        var topRecodeLabel = UILabel()
        topRecodeLabel.text = "최고기록"
        topRecodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return topRecodeLabel
    }()
    
    private var currentTopRecord : UILabel! = {
        var currentTopRecord = UILabel()
        currentTopRecord.text = "--:--:--"
        currentTopRecord.translatesAutoresizingMaskIntoConstraints = false
        return currentTopRecord
    }()
    
    private var timeFlowLabel : UILabel! = {
        var timeFlowLabel = UILabel()
        timeFlowLabel.text = "00:00:00"
        timeFlowLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeFlowLabel
    }()
    
    private var gameBoard : UIView! = {
        var gameBoard = UIView()
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        return gameBoard
    }()
//    private var timer : Timer! = {
//        var timer : Timer.
//        return timer
//    }()
    
    private var startButton : UIButton! = {
        var startButton = UIButton(type: .system)
        startButton.setTitle("PRESS TO START", for: .normal)
        startButton.backgroundColor = UIColor.orange
        startButton.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        return startButton
    }()

    private var numberCells : [UIButton]! = {
        var numberCells = [UIButton]()
        return numberCells
    }()
    private var time : Int = 0
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
        view.addSubview(gameBoard)
        view.addConstraints(gameBoardContraints())
        
        for row in 0 ..< level {
            for col in 0 ..< level {
                let cell = UIButton()
                cell.translatesAutoresizingMaskIntoConstraints = false
                cell.backgroundColor = UIColor.blue
                gameBoard.addSubview(cell)
                gameBoard.addConstraints(cellConstraints(of : cell, row : row, col : col))
                numberCells.append(cell)
                cell.addTarget(self, action: #selector(checkNumber(_:)), for: .touchUpInside)
            }
        }
        view.addSubview(startButton)
        view.addConstraints(startButtonConstraints())
        updateNumberOfCell()
    }
    
    func updateNumberOfCell() {
        let randomNumberList = makeRandomNumberList(to : level * level)
        for idx in 0..<level * level{
            numberCells[idx].setTitle("\(randomNumberList[idx])", for: .normal)
        }
    }
    
    func start(_ button : UIButton) {
        var timer = Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(flowTime), userInfo: nil, repeats: true)
        button.isHidden = true
        button.isUserInteractionEnabled = false
    }
    
    func flowTime() {
        time += 1
        print(time)
    }
    
    @objc private func checkNumber(_ button : UIButton) {
        button.isHidden = true
    }
    
    private func makeRandomNumberList(to upperBound: Int) -> [Int] {
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count != (upperBound) {
            randomNumberSet.insert(Int(arc4random_uniform(UInt32(upperBound))) + 1)
        }
        return Array(randomNumberSet)
    }
    
    private func startButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 10.0)
        let leadingConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .leading,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .leading,
                                               multiplier: 1,
                                               constant: space)
        let trailingConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .trailing,
                                               multiplier: 1,
                                               constant: -space)
        let heightConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .width,
                                               multiplier: 1,
                                               constant: 0)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func gameBoardContraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: gameBoard,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 10.0)
        let leadingConstraint = NSLayoutConstraint(item: gameBoard,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: space)
        let trailingConstraint = NSLayoutConstraint(item: gameBoard,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: -space)
        let heightConstraint = NSLayoutConstraint(item: gameBoard,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .width,
                                                  multiplier: 1,
                                                  constant: 0)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func cellConstraints(of cell : UIButton, row: Int, col : Int) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        
        if (row == 0) {
            let topConstraint = NSLayoutConstraint(item: cell,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: gameBoard,
                                                   attribute: .top,
                                                   multiplier: 1,
                                                   constant: space)
            constraints += [topConstraint]
            if col == 0 {
                let leadingConstraint = NSLayoutConstraint(item: cell,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: gameBoard,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: space)
                
                let widthConstraint = NSLayoutConstraint(item: cell,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: cell,
                                                     attribute: .height,
                                                     multiplier: 1,
                                                     constant: 0)
                constraints += [leadingConstraint, widthConstraint]
            } else {
                let leadingConstraint = NSLayoutConstraint(item: cell,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: numberCells[col - 1],
                                                           attribute: .trailing,
                                                           multiplier: 1,
                                                           constant: space)
                
                let widthConstraint = NSLayoutConstraint(item: cell,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: numberCells[col - 1],
                                                         attribute: .width,
                                                         multiplier: 1,
                                                         constant: 0)
                
                let heightConstraint = NSLayoutConstraint(item: cell,
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: numberCells[col - 1],
                                                          attribute: .height,
                                                          multiplier: 1,
                                                          constant: 0)
                constraints += [leadingConstraint, widthConstraint, heightConstraint]
                if col == level - 1 {
                    let trailingConstraint = NSLayoutConstraint(item: cell,
                                                                attribute: .trailing,
                                                                relatedBy: .equal,
                                                                toItem: gameBoard,
                                                                attribute: .trailing,
                                                                multiplier: 1,
                                                                constant: -space)
                    constraints += [trailingConstraint]
                }
            }
        }
        else {
            let topConstraint = NSLayoutConstraint(item: cell,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: numberCells[(row - 1) * level + col],
                                                   attribute: .bottom,
                                                   multiplier: 1,
                                                   constant: space)
            constraints += [topConstraint]
            
            if col == 0 {
                let leadingConstraint = NSLayoutConstraint(item: cell,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: gameBoard,
                                                           attribute: .leading,
                                                           multiplier: 1,
                                                           constant: space)
                
                let widthConstraint = NSLayoutConstraint(item: cell,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: cell,
                                                       attribute: .height,
                                                       multiplier: 1,
                                                       constant: 0)
                
                constraints += [leadingConstraint, widthConstraint]
            } else {
                
                let leadingConstraint = NSLayoutConstraint(item: cell,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: numberCells[row * level + col - 1],
                                                           attribute: .trailing,
                                                           multiplier: 1,
                                                           constant: space)
                
                let widthConstraint = NSLayoutConstraint(item: cell,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: numberCells[row * level + col - 1],
                                                         attribute: .width,
                                                         multiplier: 1,
                                                         constant: 0)
                
                let heightConstraint = NSLayoutConstraint(item: cell,
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: numberCells[row * level + col - 1],
                                                          attribute: .height,
                                                          multiplier: 1,
                                                          constant: 0)
                
                constraints += [widthConstraint , heightConstraint, leadingConstraint]
                
                if col == level - 1 {
                    let trailingConstraint = NSLayoutConstraint(item: cell,
                                                                attribute: .trailing,
                                                                relatedBy: .equal,
                                                                toItem: gameBoard,
                                                                attribute: .trailing,
                                                                multiplier: 1,
                                                                constant: -space)
                    constraints += [trailingConstraint]
                }
            }
        
        }
        
        return constraints
    }
}

