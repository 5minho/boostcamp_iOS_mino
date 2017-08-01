//
//  StartController.swift
//  ImageBoard
//
//  Created by 오민호 on 2017. 8. 1..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class StartContoller : UITabBarController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if appDelegate?.loginSession == nil {
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        } 
    }
}
