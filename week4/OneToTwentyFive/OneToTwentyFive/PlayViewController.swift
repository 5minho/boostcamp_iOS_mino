//
//  ViewController.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 22..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

//MARK:- properties and viewcontroller lifecycle
class PlayViewController: UIViewController {
    fileprivate var level = 2
    
    fileprivate var topRecodeLabel : UILabel! = {
        var topRecodeLabel = UILabel()
        topRecodeLabel.text = "최고기록"
        topRecodeLabel.textColor = UIColor.green
        topRecodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return topRecodeLabel
    }()
    
    fileprivate var currentTopRecord : UILabel! = {
        var currentTopRecord = UILabel()
        currentTopRecord.text = "- --:--:--"
        currentTopRecord.textColor = UIColor.green
        currentTopRecord.translatesAutoresizingMaskIntoConstraints = false
        return currentTopRecord
    }()
    
    fileprivate var elapsedTimeLabel : UILabel! = {
        var timeFlowLabel = UILabel()
        timeFlowLabel.text = "00:00:00"
        timeFlowLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeFlowLabel
    }()
    
    fileprivate var gameBoard : UIView! = {
        var gameBoard = UIView()
        gameBoard.translatesAutoresizingMaskIntoConstraints = false
        return gameBoard
    }()

    fileprivate var startButton : UIButton! = {
        var startButton = UIButton(type: .system)
        startButton.setTitle("PRESS TO START", for: .normal)
        startButton.backgroundColor = UIColor.orange
        startButton.addTarget(self, action: #selector(start(_:)), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()

    fileprivate var numberCells : [UIButton]! = {
        var numberCells = [UIButton]()
        return numberCells
    }()
    
    fileprivate var footerView : UIView! = {
        var footerView = UIView()
        footerView.backgroundColor = UIColor.orange
        footerView.translatesAutoresizingMaskIntoConstraints = false
        return footerView
    }()
    
    fileprivate var homeButton : UIButton! = {
        var homeButton = UIButton()
        homeButton.setTitle("HOME", for: .normal)
        homeButton.addTarget(self, action: #selector(returnHomeScreen(_:)), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        return homeButton
    }()
    
    fileprivate var historyButton : UIButton! = {
        var historyButton = UIButton()
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.addTarget(self, action: #selector(goHistoryScreen(_:)), for: .touchUpInside)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        return historyButton
    }()
    
    fileprivate var gameTimer : Timer!
    fileprivate var elapsedTime : Int = 0
    fileprivate let space : CGFloat = 8.0
    fileprivate var recordList : RecordList = RecordList()
    fileprivate var correctNumber = 1 {
        didSet {
            if isEndedGame() {
                numberCells.forEach({$0.isHidden = false})
                startButton.isHidden = false
                gameTimer.invalidate()
                correctNumber = 1
                presentRecordAlert()
            }
        }
    }
    
    fileprivate lazy var historyViewContreoller = {
        () -> HistoryViewController in
        let historyViewContreoller = HistoryViewController()
        return historyViewContreoller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        view.backgroundColor = UIColor.white
        recordList = appDelegate.recordList
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
        view.addSubview(elapsedTimeLabel)
        view.addSubview(startButton)
        footerView.addSubview(homeButton)
        footerView.addSubview(historyButton)
        view.addSubview(footerView)
        view.addConstraints(currentTopRecordConstraints())
        view.addConstraints(topRecodeLabelConstraints())
        view.addConstraints(elapsedTimeLabelConstraints())
        view.addConstraints(startButtonConstraints())
        view.addConstraints(footerViewConstraints())
        footerView.addConstraints(homeButtonConstraints())
        footerView.addConstraints(historyButtonConstraints())
    }
}

//MARK:-  internal Method
extension PlayViewController {
    fileprivate func updateNumberOfCell() {
        let randomNumberList = makeRandomNumberList(to : level * level)
        for idx in 0..<level * level{
            numberCells[idx].setTitle("\(randomNumberList[idx])", for: .normal)
        }
    }
    
    fileprivate func makeRandomNumberList(to upperBound: Int) -> [Int] {
        var randomNumberSet = Set<Int>()
        while randomNumberSet.count != (upperBound) {
            randomNumberSet.insert(Int(arc4random_uniform(UInt32(upperBound))) + 1)
        }
        return Array(randomNumberSet)
    }
    
    fileprivate func isEndedGame() -> Bool{
        return correctNumber == (level * level + 1)
    }
    
    fileprivate func presentRecordAlert() {
        let title = "Clear!"
        let message = "Enter your name"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        let ok = UIAlertAction(title: "OK", style: .default) {
            [unowned self] (_) -> Void in
            guard let nameField = alertController.textFields?.first, let name = nameField.text else {return}
            let record = Record(who: name, when: Date(), record: self.elapsedTime)
            self.elapsedTime = 0
            self.recordList.append(record)
            self.currentTopRecord?.text = (self.recordList.first?.name)! + " " + (self.recordList.first?.elapsedTimeFormatted())!
            self.historyViewContreoller.recordList = self.recordList
        }
        
        alertController.addTextField(configurationHandler: {
            $0.placeholder = "Enter your name"
        })
        alertController.addAction(cancel)
        alertController.addAction(ok)
        present(alertController, animated: false, completion: nil)
    }

}

//MARK:- Define Target Method
extension PlayViewController {
    @objc fileprivate func start(_ button : UIButton) {
        updateNumberOfCell()
        gameTimer = Timer.scheduledTimer(timeInterval: 1 / 60,
                                         target: self,
                                         selector: #selector(updateElapsedTime),
                                         userInfo: nil,
                                         repeats: true)
        button.isHidden = true
    }
    
    @objc fileprivate func updateElapsedTime() {
        elapsedTime += 1
        let secondbySixty = elapsedTime % 60
        let seconds = (elapsedTime / 60) % 60
        let minites = elapsedTime  / 3600
        elapsedTimeLabel.text = String(format: "%02d:%02d:%02d", minites, seconds, secondbySixty)
    }
    
    @objc fileprivate func checkNumber(_ button : UIButton) {
        guard let title = button.currentTitle, let buttonNumber = Int(title) else {
            return
        }
        if buttonNumber == correctNumber {
            button.isHidden = true
            correctNumber += 1
            return
        }
        
        elapsedTime += 90
    }
    
    @objc fileprivate func returnHomeScreen (_ button : UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func goHistoryScreen (_ button : UIButton) {
        navigationController?.pushViewController(historyViewContreoller, animated: true)
    }

}

//MARK:- Define Constraint
extension PlayViewController {
    fileprivate func topRecodeLabelConstraints() -> [NSLayoutConstraint] {
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
    fileprivate func currentTopRecordConstraints() -> [NSLayoutConstraint] {
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
    
    fileprivate func elapsedTimeLabelConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(item: elapsedTimeLabel,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: gameBoard,
                                                  attribute: .top,
                                                  multiplier: 1,
                                                  constant: -space)
        
        let trailingConstraint = NSLayoutConstraint(item: elapsedTimeLabel,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: -space)
        
        return [bottomConstraint, trailingConstraint]
    }
    
    fileprivate func startButtonConstraints() -> [NSLayoutConstraint] {
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
    
    fileprivate func gameBoardContraints() -> [NSLayoutConstraint] {
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
    
    fileprivate func cellConstraints(of cell : UIButton, row: Int, col : Int) -> [NSLayoutConstraint] {
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
    
    fileprivate func footerViewConstraints() -> [NSLayoutConstraint] {
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
    
    fileprivate func homeButtonConstraints() -> [NSLayoutConstraint] {
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
    
    fileprivate func historyButtonConstraints() -> [NSLayoutConstraint] {
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

