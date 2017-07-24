//
//  HomeViewController.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 24..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class HomeViewController : UIViewController {
    private var titleLabel : UILabel! = {
        var titleLabel = UILabel()
        titleLabel.text = "1 to 25"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.green
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private var playButton : UIButton! = {
        var playButton = UIButton(type: .system)
        playButton.setTitle("PLAY", for: .normal)
        playButton.backgroundColor = UIColor.orange
        playButton.addTarget(self,
                             action: #selector(pushPlayViewController(_:)),
                             for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private var historyButton : UIButton! = {
        var historyButton = UIButton(type: .system)
        historyButton.setTitle("HISTORY", for: .normal)
        historyButton.backgroundColor = UIColor.orange
        historyButton.addTarget(self,
                                action: #selector(pushHistoryViewController(_:)),
                                for: .touchUpInside)
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        return historyButton
    }()
    
    private lazy var playViewController = { () -> PlayViewController in
        let playViewController = PlayViewController()
        return playViewController
    }()
    
//    lazy var historyViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(playButton)
        view.addSubview(historyButton)
       
        view.addConstraints(titleConstraints())
        view.addConstraints(playButtonConstraints())
        view.addConstraints(historyButtonConstraints())
    }
    
    //MARK:- Target Method
    
    @objc private func pushPlayViewController(_ button : UIButton) {
        self.navigationController?.pushViewController(playViewController, animated: true)
    }
    
    @objc private func pushHistoryViewController(_ button : UIButton) {
        
    }
    
    //MARK:- Constraint
    
    private func titleConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: titleLabel,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: topLayoutGuide,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 10)
        let centerXConstraint = NSLayoutConstraint(item: titleLabel,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .centerX,
                                                        multiplier: 1,
                                                        constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: titleLabel,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .height,
                                                       multiplier: 0.1,
                                                       constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: titleLabel,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: view,
                                                      attribute: .width,
                                                      multiplier: 0.5,
                                                      constant: 0)
        return [topConstraint, centerXConstraint, heightConstraint, widthConstraint]
    }
    
    private func playButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: playButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: titleLabel,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 50)
        
        let widthConstraint = NSLayoutConstraint(item: playButton,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .width,
                                                  multiplier: 0.4,
                                                  constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: playButton,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: view,
                                                   attribute: .height,
                                                   multiplier: 0.28,
                                                   constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: playButton,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: view,
                                                  attribute: .leading,
                                                  multiplier: 1,
                                                  constant: 20)
        
    
        return [topConstraint, widthConstraint, heightConstraint, leadingConstraint]
    }

    private func historyButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: historyButton,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: titleLabel,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 50)
        
        let widthConstraint = NSLayoutConstraint(item: historyButton,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: playButton,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: historyButton,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: playButton,
                                                  attribute: .height,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: historyButton,
                                                 attribute: .trailing,
                                                 relatedBy: .equal,
                                                 toItem: view,
                                                 attribute: .trailing,
                                                 multiplier: 1,
                                                 constant: -20)
        return [topConstraint, widthConstraint, heightConstraint, trailingConstraint]
    }

}
