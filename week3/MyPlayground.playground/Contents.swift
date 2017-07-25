//: Playground - noun: a place where people can play

import Cocoa


class Test {
    var a : Int = 5 {
        didSet {
            a = 3
            print(a)
        }
    }
}

var test = Test()
test.a = 5