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
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
}
