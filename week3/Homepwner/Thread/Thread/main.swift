//
//  main.swift
//  Thread
//
//  Created by 오민호 on 2017. 7. 16..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

var result = 0

Thread.detachNewThread { 
    for i in 1...100 {
        result += i
    }
}

for i in 1...100 {
    result += i
}

print(result)
