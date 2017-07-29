//
//  ItemStore.swift
//  Homepwner
//
//  Created by 오민호 on 2017. 7. 14..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    var itemArchiveURL: URL? = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var documentDirectory = documentsDirectories.first
        return documentDirectory?.appendingPathComponent("items.archive")
    }()
    
    init() {
        if let path = itemArchiveURL?.path,
            let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [Item] {
            allItems += archivedItems
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: " + String(describing: itemArchiveURL?.path))
        if let path = itemArchiveURL?.path {
            return NSKeyedArchiver.archiveRootObject(allItems, toFile: path)
        }
        return false
    }
}
