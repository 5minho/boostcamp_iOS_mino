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
        topRecodeLabel.textColor = UIColor.green
        topRecodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return topRecodeLabel
    }()
    
    private var currentTopRecord : UILabel! = {
        var currentTopRecord = UILabel()
        currentTopRecord.text = "- --:--:--"
        currentTopRecord.textColor = UIColor.green
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
    
    //footerView 를 쓰는 화면이 많아서 재사용할 방법을 찾아보자
    private var footerView : UIView! = {
        var footerView = UIView()
        footerView.backgroundColor = UIColor.orange
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    private var homeButton : UIButton! = {
        var homeButton = UIButton()
        homeButton.setTitle("HOME", for: .normal)
        homeButton.addTarget(self, action: #selector(returnHomeScreen(_:)), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    }()
    
    private var historyButton : UIButton! = {
        var historyButton = UIButton()
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        return historyButton
    }()
    
    private var time : Int = 0
    private let space : CGFloat = 8.0
    
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
        
        view.addSubview(topRecodeLabel)
        view.addSubview(currentTopRecord)
        view.addSubview(timeFlowLabel)
        view.addSubview(startButton)
        footerView.addSubview(homeButton)
        footerView.addSubview(historyButton)
        view.addSubview(footerView)
        
        
        view.addConstraints(currentTopRecordConstraints())
        view.addConstraints(topRecodeLabelConstraints())
        view.addConstraints(timeFlowLabelConstraints())
        view.addConstraints(startButtonConstraints())
        view.addConstraints(footerViewConstraints())
        footerView.addConstraints(homeButtonConstraints())
        footerView.addConstraints(historyButtonConstraints())
        updateNumberOfCell()
    }
    
    private func updateNumberOfCell() {
        let randomNumberList = makeRandomNumberList(to : level * level)
        for idx in 0..<level * level{
            numberCells[idx].setTitle("\(randomNumberList[idx])", for: .normal)
        }
    }
    
    private func makeRandomNumberList(to upperBound: Int) -> [Int] {
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count != (upperBound) {
            randomNumberSet.insert(Int(arc4random_uniform(UInt32(upperBound))) + 1)
        }
        return Array(randomNumberSet)
    }
    
    //MARK:- Define Target Method
    
    @objc private func start(_ button : UIButton) {
        Timer.scheduledTimer(timeInterval: 1 / 60, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        button.isHidden = true
        button.isUserInteractionEnabled = false
    }
    
    @objc private func updateTime() {
        time += 1
        let secondbySixty = time % 60
        let seconds = (time / 60) % 60
        let minites = time  / 3600
        timeFlowLabel.text = String(format: "%02d:%02d:%02d", minites, seconds, secondbySixty)
    }
    
    @objc private func checkNumber(_ button : UIButton) {
        button.isHidden = true
    }
    
    @objc private func returnHomeScreen (_ button : UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK:- Define Constraint
    
    private func topRecodeLabelConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: topRecodeLabel,
                                               attribute: .bottom,
                                               relatedBy: .equal,
                                               toItem: currentTopRecord,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: -space)
        let leadingConstraint = NSLayoutConstraint(item: topRecodeLabel,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: space)
        return [bottomConstraint, leadingConstraint]
    }
    
    private func currentTopRecordConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: currentTopRecord,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: gameBoard,
                                                  attribute: .top,
                                                  multiplier: 1,
                                                  constant: -space)
        
        let leadingConstraint = NSLayoutConstraint(item: currentTopRecord,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: space)
        
        return [bottomConstraint, leadingConstraint]
    }
    
    private func timeFlowLabelConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: timeFlowLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: gameBoard,
                                                  attribute: .top,
                                                  multiplier: 1,
                                                  constant: -space)
        
        let trailingConstraint = NSLayoutConstraint(item: timeFlowLabel,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .trailing,
                                                   multiplier: 1,
                                                   constant: -space)
        
        return [bottomConstraint, trailingConstraint]
    }
    
    private func startButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: gameBoard,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .leading,
                                               relatedBy: .equal,
                                               toItem: gameBoard,
                                               attribute: .leading,
                                               multiplier: 1,
                                               constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .trailing,
                                               relatedBy: .equal,
                                               toItem: gameBoard,
                                               attribute: .trailing,
                                               multiplier: 1,
                                               constant: 0)
        let heightConstraint = NSLayoutConstraint(item: startButton,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: gameBoard,
                                               attribute: .width,
                                               multiplier: 1,
                                               constant: 0)
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func gameBoardContraints() -> [NSLayoutConstraint] {
        let widthConstraint = NSLayoutConstraint(item: gameBoard,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: gameBoard,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 0)
        let heightConstraint = NSLayoutConstraint(item: gameBoard,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .height,
                                                  multiplier: 0.5,
                                                  constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: gameBoard,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: gameBoard,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        return [widthConstraint, heightConstraint, centerXConstraint, centerYConstraint]
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
    
    private func footerViewConstraints() -> [NSLayoutConstraint] {
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
      
       return [topConstraint,bottomConstraint, widthConstraint]
    }
    
    private func homeButtonConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: homeButton,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: homeButton,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerX,
                                                   multiplier: 0.5,
                                                   constant: 0)
        let heightConstrinat = NSLayoutConstraint(item: homeButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: footerView,
                                                  attribute: .height,
                                                  multiplier: 0.8,
                                                  constant: 0)
        return [centerYConstraint, centerXConstraint, heightConstrinat]
    }
    
    private func historyButtonConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: historyButton,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        let centerXConstraint = NSLayoutConstraint(item: historyButton,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: footerView,
                                                   attribute: .centerX,
                                                   multiplier: 1.5,
                                                   constant: 0)
        let heightConstrinat = NSLayoutConstraint(item: historyButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: footerView,
                                                  attribute: .height,
                                                  multiplier: 0.8,
                                                  constant: 0)
        return [centerYConstraint, centerXConstraint, heightConstrinat]
    }
}

