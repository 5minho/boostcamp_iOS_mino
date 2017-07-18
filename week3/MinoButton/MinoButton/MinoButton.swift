//
//  MinoButton.swift
//  MinoButton
//
//  Created by 오민호 on 2017. 7. 17..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int(self.rawValue)
    }
}

@IBDesignable
class MinoButton : UIView {
    //MARK:- backgroundImageView Set up
    private lazy var backgroundImageView: UIImageView? = {
        var backgroundImageView = UIImageView()
        self.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        return backgroundImageView
    }()
    
    open var titleLabel: UILabel?
    
    open var backgroundImage: UIImage? {
        didSet {
            updateBackgroundImageView(backgroundImage!)
        }
    }
    
    private var currentState = UIControlState.normal {
        didSet {
            updateButtonByCurrentState()
        }
    }
    
    open var isEnabled : Bool = true {
        didSet {
            updateCurrentState()
        }
    }
    
    open func title(for state: UIControlState) -> String? {
        return self.titleLabel?.text
    }
    
    private var stateStringDictionary = [UIControlState : String]()
    private var stateColorDictionary = [UIControlState : UIColor]()
    
    private var actionsOfTarget = [NSObject : Set<Selector>]()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLabel()
    }
    
    //MARK:- titlLabel Set up
    private func setUpLabel() {
        self.titleLabel = UILabel()
        self.addSubview(titleLabel!)
        titleLabel?.textAlignment = .center
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        titleLabel?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }

    open func updateCurrentState() {
        self.isUserInteractionEnabled = self.isEnabled
        if !(self.isEnabled) {
            self.alpha = 0.5
        }
        else {self.alpha = 1}
    }
    
    open func backgroundImage(for state : UIControlState)-> UIImage? {
        return backgroundImageView?.image
    }
    
    open func setBackgroundImage(image : UIImage?, for: UIControlState) {
        self.backgroundImageView?.image = image
    }
    
    open func setTitle(title: String, for state: UIControlState) {
        stateStringDictionary[state] = title
        updateButtonByCurrentState()
    }
    
    func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        stateColorDictionary[state] = color
        updateButtonByCurrentState()
    }
    
    private func updateButtonByCurrentState() {
        updateTitleString()
        updateTitleColor()
    }
    
    private func updateTitleString() {
        for (state, title) in stateStringDictionary {
            if currentState == state {
                titleLabel?.text = title
                break
            }
        }
    }
    
    private func updateTitleColor() {
        for (state, color) in stateColorDictionary {
            if currentState == state {
                titleLabel?.textColor = color
                break
            }
        }
    }
    
    open func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        if target == nil {
            
        }
        guard let target = target as? NSObject else {return}
        if let _ = actionsOfTarget[target] {
            actionsOfTarget[target]?.insert(action)
            return
        }
        actionsOfTarget[target] = [action]
    }
    
    private func updateBackgroundImageView(_ image: UIImage) {
        backgroundImageView?.image = image
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentState == .selected {
            currentState = currentState.union(.highlighted)
            return
        }
        currentState = .highlighted
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for (target, selectors) in actionsOfTarget {
            for selector in selectors {
                target.perform(selector, with: self)
            }
        }
        
        if currentState == UIControlState.selected.union(.highlighted) {
            currentState = .normal
            return
        }
        currentState = .selected
    }

}
