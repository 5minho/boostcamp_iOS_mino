//
//  Secretary.swift
//  TestExample
//
//  Created by 오민호 on 2017. 7. 20..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation


protocol CEODelegate: NSObjectProtocol {
    func drive(ceo: CEO, to destination: String)
    func write(ceo: CEO, about: String) -> String
    
    var driverLicense: Any { get }
    
    func schedule(ceo: CEO, date: Date) -> String
}


class DelegateObject: NSObject, CEODelegate {
    var driverLicense: Any = "운전면허증"
    
    func drive(ceo: CEO, to destination: String) {
        print(destination + "으로 갑니다")
        
        
    }
    
    func write(ceo: CEO, about: String) -> String {
        return "옛다" + about
    }
    
    func schedule(ceo: CEO, date: Date) -> String {
        return "없어 너는 없어"
    }

    
}
