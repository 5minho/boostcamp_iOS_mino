//
//  RecordList.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class RecordList {
    private var recordList : [Record] = []
    
    open var first : Record? {
        return recordList[0]
    }
    open var count : Int {
        return recordList.count
    }
    
    open func append(_ newRecode : Record) {
        recordList.append(newRecode)
    }
    
    open func sort() {
        recordList.sort(by: <)
    }
    open func index(at : Int) -> Record{
        return recordList[at]
    }
    
    private let itemArchiveURL : URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    open func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(recordList, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Record] {
            recordList += archivedItems
        }
    }
}
