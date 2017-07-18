//
//  ViewController.swift
//  MinoButton
//
//  Created by 오민호 on 2017. 7. 17..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var minoButton: MinoButton!
    var disableButton : MinoButton!
    var uiButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        minoButton = MinoButton(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
        disableButton = MinoButton(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        minoButton.backgroundColor = UIColor.black

        minoButton.setTitle(title: "normal", for: .normal)
        minoButton.setTitle(title: "highlighted1", for: .highlighted)
        minoButton.setTitle(title: "selected", for: .selected)
        minoButton.setTitle(title: "highlighted2", for: [.selected, .highlighted])
        minoButton.setTitleColor(UIColor.yellow, for: .normal)
        minoButton.setTitleColor(UIColor.white, for: .highlighted)
        minoButton.setTitleColor(UIColor.green, for: .selected)
        minoButton.setTitleColor(UIColor.red, for: [.selected, .highlighted])
        
        disableButton.setTitle(title: "Disable the button", for: .normal)
        disableButton.setTitle(title: "able the button", for: .selected)
        
        view.addSubview(minoButton)
        view.addSubview(disableButton)
        
    }
    
    func changeState(_ sender: MinoButton) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

