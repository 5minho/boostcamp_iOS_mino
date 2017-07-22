//
//  ViewController.swift
//  Quiz
//
//  Created by 오민호 on 2017. 6. 30..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let questions: [String] = ["From whar is cognac made?",
                               "What is 7+7?",
                               "What is the capital of Vermont?"]
    let answer: [String] = ["Grapes",
                            "14",
                            "Montpelier"]
    
    var currentQuestionIndex: Int = 0
    
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }

    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
//        let space = UILayoutGuide()
//        nextQuestionLabel.trailingAnchor.constraint(equalTo: space.leadingAnchor).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        currentQuestionIndex %= questions.count
        nextQuestionLabel.text = questions[currentQuestionIndex]
        answerLabel.text = "???"
        
        animateLabelTranitions()
    }

    @IBAction func showAnswer(_ sender: UIButton) {
        answerLabel.text = answer[currentQuestionIndex]
    }
    
    func animateLabelTranitions() {
        
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        print(screenWidth)
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: [],
                       animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: {
            _ in
            swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
            swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
            self.updateOffScreenLabel()
        })
    }

}

