//
//  Record.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class Record : NSObject {
    let name : String
    let dateRecorded : String
    let elapsedTime : Int
    
    private let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }()
    
    init(who name : String, when dateRecorded : Date, record elapsedTime : Int) {
        self.name = name
        self.dateRecorded = dateFormatter.string(from: dateRecorded)
        self.elapsedTime = elapsedTime
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        dateRecorded = aDecoder.decodeObject(forKey: "dateRecorded") as! String
        elapsedTime = aDecoder.decodeInteger(forKey: "elapsedTime")
        super.init()
    }
    
    open func elapsedTimeFormatted() -> String {
        let secondbySixty = elapsedTime % 60
        let seconds = (elapsedTime / 60) % 60
        let minites = elapsedTime  / 3600
        return String(format: "%02d:%02d:%02d", minites, seconds, secondbySixty)
    }
}

extension Record {
    static func < (left : Record, right : Record) -> Bool {
        return left.elapsedTime < right.elapsedTime
    }
}

extension Record : NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(dateRecorded, forKey: "dateRecorded")
        aCoder.encode(elapsedTime, forKey: "elapsedTime")
    }
}
