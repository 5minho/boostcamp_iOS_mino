//
//  CEO.swift
//  TestExample
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class CEO {
    weak var delegate: CEODelegate?
    
    
    func goTo(_ someWhere: String) {
        self.delegate?.drive(ceo: self, to: someWhere)
    }
    
    func write(_ topic: String) -> String {
        return self.delegate?.write(ceo: self, about: topic) ?? "i can't do it"
    }
}
