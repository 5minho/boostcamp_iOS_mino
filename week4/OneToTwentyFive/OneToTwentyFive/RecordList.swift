//
//  RecordList.swift
//  OneToTwentyFive
//
//  Created by 오민호 on 2017. 7. 25..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class RecordList {
    fileprivate var recordList : [Record] = []
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Record] {
            recordList += archivedItems
        }
    }
    
    open var first : Record? {
        return recordList[0]
    }
    open var count : Int {
        return recordList.count
    }
    
    open func append(_ newRecode : Record) {
        recordList.append(newRecode)
        recordList.sort(by: <)
    }

    open func index(at : Int) -> Record{
        return recordList[at]
    }
    
    open func clear() {
        recordList.removeAll()
    }
    
    open func isEmpty() -> Bool {
        return recordList.isEmpty
    }
    
    fileprivate let itemArchiveURL : URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
}

extension RecordList {
    open func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(recordList, toFile: itemArchiveURL.path)
    }
}
