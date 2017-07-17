//
//  main.swift
//  ThreadExample
//
//  Created by 오민호 on 2017. 7. 17..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation

class MyOperation: Operation {
    var index: Int?
    
    override func main() {
        if let index = self.index {
            print("From My Operation \(index)")
        }
    }
    
    init(index: Int) {
        super.init()
        self.index = index
    }
}

class MyWork {
    let queue = OperationQueue()
    init() {
        self.queue.addOperation(MyOperation(index: 0))
        self.queue.addOperation(MyOperation(index: 1))
        self.queue.addOperation(MyOperation(index: 2))
        self.queue.addOperation(MyOperation(index: 3))
        self.queue.addOperation(MyOperation(index: 4))
    }
}

let work = MyWork()

while true {
    sleep(1)
}

