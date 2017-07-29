//
//  Model.swift
//  UnitTest
//
//  Created by 오민호 on 2017. 7. 29..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class Model {
    var result = 0
    
    func sum(from : Int, to : Int) -> Int{
        for i in from...to {
            result += i
        }
        return result
    }
}
